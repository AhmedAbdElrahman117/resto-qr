import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:resto_qr/Core/Utils/app_permissions.dart';
import 'package:resto_qr/Core/Utils/location.dart';

class LocationService {
  AppPermissions permissions = AppPermissions();

  Location location = Location();

  Future<Position?> getCurrentLocation({
    required Function(Location location) onDisableGPS,
    required Function(Location location) onPermanentlyDenied,
    required Function(Location location) onDeny,
  }) async {
    var permissionRequest = await permissions.requestLocationPermission();

    if (permissionRequest == .granted) {
      bool enabled = await location.isGPSActivated();

      if (!enabled) {
        onDisableGPS(location);
        return null;
      }

      return await location.getCurrentLocation();
    } else if (permissionRequest == .permanentlyDenied) {
      onPermanentlyDenied(location);
      return null;
    }

    onDeny(location);
    return null;
  }

  Future<Stream<Position>?> getStreamLocation({
    required Function(Location location) onDisableGPS,
    required Function(Location location) onPermanentlyDenied,
    required Function(Location location) onDeny,
  }) async {
    var permissionRequest = await permissions.requestLocationPermission();

    if (permissionRequest == .granted) {
      bool enabled = await location.isGPSActivated();

      if (!enabled) {
        onDisableGPS(location);
        return null;
      }

      return location.getLocationStream();
    } else if (permissionRequest == .permanentlyDenied) {
      onPermanentlyDenied(location);
      return null;
    }

    onDeny(location);
    return null;
  }
}
