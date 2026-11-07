import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/assets.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: .circular(12),
      type: .canvas,
      child: Container(
        padding: const .all(20),
        decoration: BoxDecoration(
          color: AppTheme().primaryBackground(context),
          borderRadius: .circular(12),
          boxShadow: [
            BoxShadow(
              color: AppConstants().neonBlue.withValues(alpha: 0.7),
              blurRadius: 14,
              offset: const Offset(0, 8),
              spreadRadius: 8,
            ),
            BoxShadow(
              color: AppConstants().neonBlue.withValues(alpha: 0.7),
              blurRadius: 14,
              offset: const Offset(0, -8),
              spreadRadius: 8,
            ),
          ],
        ),
        child: SvgPicture.asset(Assets.imagesLogo),
      ),
    );
  }
}
