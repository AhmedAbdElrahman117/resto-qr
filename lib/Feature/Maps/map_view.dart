import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/location.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/loading_widget.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';
import 'package:resto_qr/Feature/Maps/View%20Model/map_cubit.dart';
import 'package:resto_qr/Feature/Maps/View%20Model/map_state.dart';
import 'package:resto_qr/Feature/Maps/Widgets/location_details.dart';
import 'package:resto_qr/Feature/Maps/Widgets/my_location_button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapboxMap? mapController;
  CameraOptions? position;
  Timer? _debounceTimer;
  Position? lastFetchedPosition;
  double zoom = 14;
  final ValueNotifier<PlaceModel?> selectedPlace = ValueNotifier<PlaceModel?>(
    null,
  );

  late final AppLifecycleListener _lifecycleListener;
  final ValueNotifier<bool> showCurrentLocationButton = ValueNotifier<bool>(
    false
  );

  List<PlaceModel> _cachedPlaces = [];
  MbxImage? _markerImage;
  bool _isStyleLoaded = false;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onPause: () {
        if (mounted) context.read<MapCubit>().stopLocationStream();
      },
      onResume: () {
        if (mounted) context.read<MapCubit>().resumeLocationStream();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocWidget<MapCubit, MapState>(
          listener: _listener,
          buildWhen: (previous, current) =>
              current is MapInitalized ||
              current is MapLoadingInitState ||
              current is MapInitalizationError,
          builder: (context, state) {
            if (state is MapLoadingInitState) {
              return const Center(child: LoadingWidget());
            } else if (state is MapInitalizationError) {
              return EmptyStateWidget(
                title: 'Error',
                message: state.message,
              );
            }

            final location = (state as MapInitalized);
            _markerImage = location.marker;

            return Stack(
              children: [
                MapWidget(
                  viewport: CameraViewportState(
                    center: Point(
                      coordinates: Position(
                        location.initialLng ?? 0,
                        location.initialLat ?? 0,
                      ),
                    ),
                    zoom: zoom,
                  ),
                  onMapCreated: _onMapCreated,
                  onCameraChangeListener: _onCameraChangeListener,
                  onStyleLoadedListener: (styleLoadedEventData) {
                    _onStyleLoaded(markerBytes: _markerImage);
                  },
                  // ignore: deprecated_member_use
                  onTapListener: (MapContentGestureContext tapContext) {
                    if (selectedPlace.value != null) {
                      selectedPlace.value = null;
                    }
                  },
                  styleUri:
                      context.watch<AppCubit>().state.mode == ThemeMode.dark
                      ? MapboxStyles.DARK
                      : MapboxStyles.STANDARD,
                ),

                Align(
                  alignment: .bottomCenter,
                  child: Container(
                    width: .infinity,
                    padding: const .symmetric(vertical: 24, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const .only(
                        topLeft: .circular(16),
                        topRight: .circular(16),
                      ),
                      color: AppTheme().primaryBackground(context),
                    ),
                    child: ValueListenableBuilder<PlaceModel?>(
                      valueListenable: selectedPlace,
                      builder: (context, value, child) => AnimatedSize(
                        duration: const Duration(milliseconds: 150),
                        child: value != null
                            ? LocationDetails(
                                place: value,
                                onSelect: () {
                                  Navigation().pop(context, value);
                                },
                              )
                            : Text(
                                'Select your restaurant',
                                style: AppText().bold24(context),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: showCurrentLocationButton,
        builder: (context, value, child) {
          if (!value) return const SizedBox.shrink();
          return child!;
        },
        child: MyLocationButton(
          onPressed: () async {
            if (position?.center != null) {
              await mapController?.flyTo(
                CameraOptions(
                  center: Point(
                    coordinates: Position(
                      position!.center!.coordinates.lng,
                      position!.center!.coordinates.lat,
                    ),
                  ),
                ),
                MapAnimationOptions(duration: 500),
              );
            }
          },
        ),
      ),
    );
  }

  void _onCameraChangeListener(CameraChangedEventData cameraChangedEventData) {
    zoom = cameraChangedEventData.cameraState.zoom.toDouble();
    final currentLng = cameraChangedEventData.cameraState.center.coordinates.lng
        .toDouble();
    final currentLat = cameraChangedEventData.cameraState.center.coordinates.lat
        .toDouble();

    if (lastFetchedPosition != null) {
      double distanceMoved = Location().distanceBetween(
        lastFetchedPosition!.lat.toDouble(),
        lastFetchedPosition!.lng.toDouble(),
        currentLat,
        currentLng,
      );

      if (distanceMoved < 1000) return;
    }

    if (_debounceTimer?.isActive == true) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      lastFetchedPosition = Position(currentLng, currentLat);
      context.read<MapCubit>().getMapLocations(
        lng: currentLng,
        lat: currentLat,
      );
    });
  }

  String _createGeoJson(List<PlaceModel> places) {
    final features = places.map((place) {
      return {
        "type": "Feature",
        "geometry": {
          "type": "Point",
          "coordinates": [place.lng, place.lat],
        },
        "properties": place.toJson(),
      };
    }).toList();

    return jsonEncode({
      "type": "FeatureCollection",
      "features": features,
    });
  }

  Future<void> _updateOrAddPlacesSource(List<PlaceModel> places) async {
    if (mapController == null || !_isStyleLoaded || places.isEmpty) return;

    final geoJsonString = _createGeoJson(places);
    final textColor = AppTheme().primaryText(context, false).toARGB32();

    final sourceExists =
        await mapController?.style.styleSourceExists("places-source") ?? false;

    if (sourceExists) {
      final source =
          await mapController?.style.getSource("places-source")
              as GeoJsonSource;
      await source.updateGeoJSON(geoJsonString);
    } else {
      await mapController?.style.addSource(
        GeoJsonSource(
          id: "places-source",
          data: geoJsonString,
          cluster: true,
          clusterMinPoints: 2,
          clusterMaxZoom: 14,
          clusterRadius: 50,
        ),
      );

      await mapController?.style.addLayer(
        CircleLayer(
          id: "clusters",
          sourceId: "places-source",
          filter: ['has', 'point_count'],
          circleColor: AppConstants().neonBlue.toARGB32(),
          circleRadius: 18.0,
          circleStrokeWidth: 2.0,
          circleStrokeColor: Colors.white.toARGB32(),
        ),
      );

      await mapController?.style.addLayer(
        SymbolLayer(
          id: "cluster-count",
          sourceId: "places-source",
          filter: ['has', 'point_count'],
          textField: '{point_count}',
          textSize: 14.0,
          textColor: textColor,
        ),
      );

      await mapController?.style.addLayer(
        SymbolLayer(
          id: "unclustered-points",
          sourceId: "places-source",
          filter: [
            '!',
            ['has', 'point_count'],
          ],
          iconImage: 'custom-marker',
          iconSize: 0.25,
          textField: '{name}',
          textOffset: [0.0, 2.5],
          textColor: textColor,
        ),
      );
    }
  }

  void _listener(BuildContext context, MapState state) async {
    if (state is MapInitalized) {
      MapboxOptions.setAccessToken(state.mapKey);
      _markerImage = state.marker;

      position = CameraOptions(
        center: Point(
          coordinates: Position(state.initialLng!, state.initialLat!),
        ),
        zoom: zoom,
      );
    } else if (state is MapLocationUpdated) {
      position = CameraOptions(
        center: Point(
          coordinates: Position(state.lng, state.lat),
        ),
        zoom: zoom,
      );
      await updateLocation();
    } else if (state is MapPlacesLoaded) {
      _cachedPlaces = state.places;
      await _updateOrAddPlacesSource(_cachedPlaces);
    }
  }

  void _onStyleLoaded({MbxImage? markerBytes}) async {
    _isStyleLoaded = true;

    if (markerBytes != null) {
      try {
        await mapController?.style.addStyleImage(
          'custom-marker',
          3.0,
          markerBytes,
          false,
          [],
          [],
          null,
        );
      } catch (e) {
        log('Error adding style image: $e');
      }
    }

    if (_cachedPlaces.isNotEmpty) {
      await _updateOrAddPlacesSource(_cachedPlaces);
    }
  }

  void _onMapCreated(MapboxMap controller) async {
    mapController = controller;
    await updateLocation();
    showCurrentLocationButton.value = true;

    mapController?.addInteraction(
      TapInteraction(
        FeaturesetDescriptor(layerId: 'unclustered-points'),
        (feature, context) {
          final properties = feature.properties as Map<String, dynamic>;

          selectedPlace.value = PlaceModel(
            id: properties['id'] as String,
            name: properties['name'] as String,
            lng: (properties['lng'] as num).toDouble(),
            lat: (properties['lat'] as num).toDouble(),
            address: properties['address'] as String,
          );
        },
      ),
    );

    mapController?.addInteraction(
      TapInteraction(
        FeaturesetDescriptor(layerId: 'clusters'),
        (feature, context) async {
          await mapController?.flyTo(
            CameraOptions(
              center: context.point,
              zoom: zoom + 2.5,
            ),
            MapAnimationOptions(duration: 500),
          );
        },
      ),
    );
  }

  Future<void>? updateLocation() {
    return mapController?.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        puckBearingEnabled: true,
        showAccuracyRing: true,
      ),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _lifecycleListener.dispose();
    selectedPlace.dispose();
    showCurrentLocationButton.dispose();
    super.dispose();
  }
}
