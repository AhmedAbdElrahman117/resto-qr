import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({
    super.key,
    this.onPressed,
    this.label,
    this.icon,
    this.labelText,
    this.backgroundColor,
    this.border,
    this.iconColor,
    this.iconAlignment,
    this.borderRadius,
  });

  final void Function()? onPressed;
  final Widget? label;
  final String? labelText;
  final IconData? icon;
  final Color? backgroundColor;
  final BorderSide? border;
  final Color? iconColor;
  final IconAlignment? iconAlignment;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: .circular(borderRadius ?? 12),
          side: border ?? BorderSide.none,
        ),
        backgroundColor: backgroundColor ?? AppConstants().neonBlue,
        fixedSize: Size(
          MediaQuery.sizeOf(context).width * 0.8,
          60,
        ),
      ),
      icon: icon != null
          ? Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: 24,
            )
          : null,
      iconAlignment: iconAlignment ?? .end,
      label: setLabel(context),
    );
  }

  dynamic setLabel(BuildContext context) {
    if (label != null) {
      return label;
    } else if (labelText != null) {
      return Text(
        labelText!,
        style: AppText().semiBold16(context, Colors.white),
      );
    } else {
      throw ('Label or LabelText must be set');
    }
  }
}
