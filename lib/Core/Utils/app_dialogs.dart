import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class AppDialogs {
  AppDialogs._();

  static AppDialogs? _instance;

  factory AppDialogs() => _instance ??= AppDialogs._();

  Future<T?> showDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required Widget child,
  }) async {
    return await showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.8),
      transitionDuration: .new(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, animation, secondaryAnimation) => child,
    );
  }
}

class AppSheets {
  AppSheets._();

  static AppSheets? _instance;

  factory AppSheets() => _instance ??= AppSheets._();

  Future<T?> showSheet<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required Widget child,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppTheme().primaryBackground(context, false),
      barrierColor: Colors.black.withValues(alpha: 0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: .vertical(top: .circular(16)),
      ),
      showDragHandle: true,
      useSafeArea: true,
      barrierLabel: '',
      isDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
}
