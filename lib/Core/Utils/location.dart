import 'package:geolocator/geolocator.dart';

class Location {
  Location._();

  static Location? _instance;

  factory Location() => _instance ??= Location._();

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Future<Position> getCurrentLocation() async =>
      await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

  Stream<Position> getLocationStream() =>
      Geolocator.getPositionStream(locationSettings: locationSettings);

  Stream<ServiceStatus> getGPSStatusStream() =>
      Geolocator.getServiceStatusStream();

  Future<bool> openAppSettings() async => await Geolocator.openAppSettings();

  Future<bool> isGPSActivated() async =>
      await Geolocator.isLocationServiceEnabled();

  Future<bool> openLocationSettingsPage() async =>
      await Geolocator.openLocationSettings();

  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
