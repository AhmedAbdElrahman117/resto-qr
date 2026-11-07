import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.padding = const .all(16),
    required this.child,
  });

  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        elevation: 24,
        backgroundColor: AppTheme().primaryBackground(context),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
          side: BorderSide(
            color: AppTheme().borderColor(context),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
