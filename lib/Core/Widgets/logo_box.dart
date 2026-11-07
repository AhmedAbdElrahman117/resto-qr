import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class LogoBox extends StatelessWidget {
  const LogoBox({
    super.key,
    this.padding,
    this.radius,
    required this.child,
    this.showShadow = true,
  });

  final double? padding;
  final double? radius;
  final Widget child;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(padding ?? 20),
      decoration: BoxDecoration(
        border: .all(
          color: const Color(0xFF2BADEE),
          width: 1.5,
        ),
        borderRadius: .circular(radius ?? 12),
        boxShadow: showShadow ? fullShadow(context) : semiShadow(context),
        gradient: LinearGradient(
          colors: [
            Color(0xFF2BADEE).withValues(alpha: 0.2),
            Color(0xFF2BADEE).withValues(alpha: 0.05),
          ],
        ),
      ),
      child: child,
    );
  }

  List<BoxShadow> fullShadow(BuildContext context) {
    return [
      BoxShadow(
        color: AppTheme().shadowColor(context).withValues(alpha: 0.2),
        blurRadius: 16,
        spreadRadius: 16,
      ),
      BoxShadow(
        color: AppTheme().shadowColor(context).withValues(alpha: 0.15),
        blurRadius: 8,
        spreadRadius: 8,
      ),
    ];
  }

  List<BoxShadow> semiShadow(BuildContext context) {
    return [
      BoxShadow(
        color: AppTheme().shadowColor(context).withValues(alpha: 0.15),
        blurRadius: 8,
        spreadRadius: 8,
      ),
    ];
  }
}
