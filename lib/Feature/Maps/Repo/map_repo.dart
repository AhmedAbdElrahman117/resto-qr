import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/supabase_function.dart';
import 'package:resto_qr/Core/Utils/location.dart';
import 'package:resto_qr/Feature/Maps/Model/cached_area.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';
import 'package:resto_qr/Feature/Maps/Service/location_service.dart';

class MapRepo {
  LocationService locationService = LocationService();

  final http.Client _httpClient = http.Client();

  Set<String> fetchedPlacesID = {};

  List<CachedArea> searchedAreas = [];

  final List<PlaceModel> allPlaces = [];

  final SupabaseFunction supabaseFunction = SupabaseFunction();

  final String baseURL =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';

  final key = 'AIzaSyBK21B3rZUqK77ck2rvKSTTN_CX86QHFOw';

  Future<Either<AppException, String>> getMapKey() async {
    try {
      final res = await supabaseFunction.call(name: 'get_map_key');

      return right(res.data['mapKey'] as String);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Stream<Position>?>> streamLocation({
    required Function(Location location) onDisableGPS,
    required Function(Location location) onPermanentlyDenied,
    required Function(Location location) onDeny,
  }) async {
    try {
      return right(
        await locationService.getStreamLocation(
          onDisableGPS: onDisableGPS,
          onPermanentlyDenied: onPermanentlyDenied,
          onDeny: onDeny,
        ),
      );
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Position?>> getCurrentLocation({
    required Function(Location location) onDisableGPS,
    required Function(Location location) onDeny,
    required Function(Location location) onPermanentlyDenied,
  }) async {
    try {
      return right(
        await locationService.getCurrentLocation(
          onDisableGPS: onDisableGPS,
          onPermanentlyDenied: onPermanentlyDenied,
          onDeny: onDeny,
        ),
      );
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  // Changed from Future to Stream, added async*
  Stream<Either<AppException, List<PlaceModel>>> getMapLocations({
    required double lng,
    required double lat,
  }) async* {
    try {
      log('Fetching places for the area: ($lat, $lng)');
      bool isAreaAlreadySearched = false;

      for (var area in searchedAreas) {
        double distanceInMeters = Geolocator.distanceBetween(
          lat,
          lng,
          area.lat,
          area.lng,
        );

        if (distanceInMeters < 1000) {
          isAreaAlreadySearched = true;
          break;
        }
      }

      if (isAreaAlreadySearched) {
        log('Area already searched. Yielding cached places.');
        yield right(allPlaces); // Yield immediately if cached
        return;
      }

      searchedAreas.add(CachedArea(lat: lat, lng: lng));

      final baseUrlWithParams =
          '$baseURL?location=$lat,$lng&key=$key&type=restaurant&radius=1500';
      String? nextPageToken;

      do {
        final url = nextPageToken == null
            ? baseUrlWithParams
            : '$baseURL?pagetoken=$nextPageToken&key=$key';

        var response = await _httpClient.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final String responseBody = response.body;
          final Set<String> currentIds = fetchedPlacesID.toSet();

          final parsedData = await Isolate.run(() {
            final data = json.decode(responseBody);
            final places = data['results'] as List;
            final token = data['next_page_token'] as String?;
            final List<PlaceModel> isolatePlaces = [];

            for (var place in places) {
              final String rawId = place['place_id'];
              if (!currentIds.contains(rawId)) {
                isolatePlaces.add(PlaceModel.fromJson(place));
              }
            }

            return {
              'places': isolatePlaces,
              'token': token,
            };
          });

          final parsedPlaces = parsedData['places'] as List<PlaceModel>;
          nextPageToken = parsedData['token'] as String?;

          for (var place in parsedPlaces) {
            fetchedPlacesID.add(place.id);
            allPlaces.add(place);
          }

          yield right(List.from(allPlaces));

          if (nextPageToken != null) {
            log('Found more places. Waiting 2 seconds for next_page_token...');
            await Future.delayed(const Duration(seconds: 2));
          }
        } else {
          log('Failed to fetch places: ${response.body}');
          break;
        }
      } while (nextPageToken != null);
    } catch (e, stackTrace) {
      yield left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }
}
