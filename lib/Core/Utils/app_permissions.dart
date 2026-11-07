import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  Future<PermissionResult> requestLocationPermission() async {
    var res = await Permission.location.request();

    if (res.isGranted || res.isLimited) {
      return PermissionResult.granted;
    } else if (res.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    } else {
      return PermissionResult.denied;
    }
  }
}

enum PermissionResult {
  granted,
  denied,
  permanentlyDenied,
}
