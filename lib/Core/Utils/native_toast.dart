import 'package:fluttertoast/fluttertoast.dart';

class NativeToast {
  NativeToast._();

  static final NativeToast _instance = NativeToast._();

  factory NativeToast() => _instance;

  void show({required String message, bool short = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: short ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
