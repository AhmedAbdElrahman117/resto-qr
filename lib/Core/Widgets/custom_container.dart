import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.padding,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    this.borderColor,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppTheme().fillColor(context),
        borderRadius: .circular(borderRadius ?? 12),
        border: Border.all(
          color: borderColor ?? AppTheme().borderColor(context),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}
