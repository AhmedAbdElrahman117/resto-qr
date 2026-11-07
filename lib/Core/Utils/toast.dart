import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class Toast {
  Toast._();

  static Toast? _instance;

  factory Toast() => _instance ??= Toast._();

  void showSuccess({
    required String title,
    required String description,
  }) {
    _toast(
      type: .success,
      title: title,
      description: description,
    );
  }

  void showError({
    required String title,
    required String description,
  }) {
    _toast(
      type: .error,
      title: title,
      description: description,
    );
  }

  void _toast({
    required ToastificationType type,
    required String title,
    required String description,
  }) {
    toastification.show(
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(title),
      description: Text(description),
      applyBlurEffect: true,
      closeOnClick: true,
      dragToClose: true,
      showProgressBar: true,
      dismissDirection: .horizontal,
    );
  }
}
