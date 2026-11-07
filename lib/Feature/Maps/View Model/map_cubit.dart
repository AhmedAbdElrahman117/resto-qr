import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/location.dart';
import 'package:resto_qr/Feature/Maps/Repo/map_repo.dart';
import 'package:resto_qr/Feature/Maps/View%20Model/map_state.dart';

class MapCubit extends Cubit<MapState> with SafeCubit {
  MapCubit() : super(MapInitalState());

  final MapRepo repo = MapRepo();

  StreamSubscription? _locationStream;
  StreamSubscription? _gpsStatusStream;
  StreamSubscription? _placesSubscription;

  MbxImage? marker;

  Future<MbxImage?> loadCustomMarkerImage() async {
    final ByteData byteData = await rootBundle.load(Assets.imagesMarker);
    final Uint8List imageBytes = byteData.buffer.asUint8List();

    final image = await decodeImageFromList(imageBytes);

    return MbxImage(
      width: image.width,
      height: image.height,
      data: imageBytes,
    );
  }

  void initMap({
    required Function(Location location) onDisableGPS,
    required Function(Location location) onPermanentlyDenied,
    required Function(Location location) onDeny,
  }) async {
    safeEmit(MapLoadingInitState());

    var key = await repo.getMapKey();

    key.fold(
      (l) => safeEmit(MapInitalizationError(message: l.message)),
      (key) async {
        var locationRes = await repo.getCurrentLocation(
          onDisableGPS: onDisableGPS,
          onDeny: onDeny,
          onPermanentlyDenied: onPermanentlyDenied,
        );

        marker ??= await loadCustomMarkerImage();

        double? initLat;
        double? initLng;

        locationRes.fold(
          (l) => safeEmit(MapLocationError(message: l.message)),
          (pos) async {
            if (pos != null) {
              initLat = pos.latitude;
              initLng = pos.longitude;

              await getMapLocations(lng: initLng!, lat: initLat!);
            }
          },
        );

        startLocationStream(
          onDisableGPS: onDisableGPS,
          onDeny: onDeny,
          onPermanentlyDenied: onPermanentlyDenied,
        );

        _gpsStatusStream = repo.locationService.location
            .getGPSStatusStream()
            .listen((status) {
              if (status == ServiceStatus.disabled) {
                onDisableGPS(repo.locationService.location);
                _locationStream?.cancel();
                _locationStream = null;
              } else if (status == ServiceStatus.enabled) {
                if (_locationStream == null) {
                  startLocationStream(
                    onDisableGPS: onDisableGPS,
                    onDeny: onDeny,
                    onPermanentlyDenied: onPermanentlyDenied,
                  );
                }
              }
            });

        safeEmit(
          MapInitalized(
            initialLat: initLat,
            initialLng: initLng,
            marker: marker,
            mapKey: key,
          ),
        );
      },
    );
  }

  void startLocationStream({
    required Function(Location location) onDisableGPS,
    required Function(Location location) onDeny,
    required Function(Location location) onPermanentlyDenied,
  }) async {
    var res = await repo.streamLocation(
      onDisableGPS: onDisableGPS,
      onDeny: onDeny,
      onPermanentlyDenied: onPermanentlyDenied,
    );

    res.fold(
      (l) => safeEmit(MapLocationError(message: l.message)),
      (stream) {
        _locationStream = stream?.listen(
          (position) {
            safeEmit(
              MapLocationUpdated(
                lat: position.latitude,
                lng: position.longitude,
              ),
            );
          },
          onError: (e) => safeEmit(MapLocationError(message: e.message)),
        );
      },
    );
  }

  Future<void> getMapLocations({
    required double lng,
    required double lat,
  }) async {
    // 1. Cancel previous stream if the user moves the map while a background fetch is happening
    await _placesSubscription?.cancel();

    safeEmit(MapLoadingPlaces());

    // 2. Listen to the new generator stream
    _placesSubscription = repo.getMapLocations(lng: lng, lat: lat).listen(
      (res) {
        res.fold(
          (l) => safeEmit(MapPlacesError(message: l.message)),
          (places) {
            safeEmit(MapPlacesLoaded(places: places));
          },
        );
      },
    );
  }

  void stopLocationStream() {
    _locationStream?.cancel();
    _locationStream = null;
  }

  void resumeLocationStream() {
    if (_locationStream == null) {
      startLocationStream(
        onDisableGPS: (loc) {},
        onDeny: (loc) {},
        onPermanentlyDenied: (loc) {},
      );
    }
  }

  @override
  Future<void> close() {
    _locationStream?.cancel();
    _locationStream = null;
    _gpsStatusStream?.cancel();
    _gpsStatusStream = null;
    _placesSubscription?.cancel();
    _placesSubscription = null;
    return super.close();
  }
}
