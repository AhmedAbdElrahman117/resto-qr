import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';

class MapState {}

class MapInitalState extends MapState {}

class MapLoadingInitState extends MapState {}

class MapInitalized extends MapState {
  final double? initialLat;
  final double? initialLng;
  final MbxImage? marker;
  final String mapKey;

  MapInitalized({
    this.initialLat,
    this.initialLng,
    this.marker,
    required this.mapKey,
  });
}

class MapInitalizationError extends MapState {
  final String message;

  MapInitalizationError({required this.message});
}

class MapLocationUpdated extends MapState {
  final double lat;
  final double lng;

  MapLocationUpdated({required this.lat, required this.lng});
}

class MapLocationError extends MapState {
  final String message;

  MapLocationError({required this.message});
}

class MapLoadingPlaces extends MapState {}

class MapPlacesLoaded extends MapState {
  final List<PlaceModel> places;

  MapPlacesLoaded({required this.places});
}

class MapPlacesError extends MapState {
  final String message;

  MapPlacesError({required this.message});
}
