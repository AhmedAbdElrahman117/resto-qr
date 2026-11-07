import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.padding, this.size});

  final IconData icon;
  final double? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(padding ?? 20),
      alignment: .center,
      decoration: BoxDecoration(
        shape: .circle,
        color: AppConstants().neonBlue.withValues(
          alpha: 0.15,
        ),
      ),
      child: Icon(
        icon,
        color: AppConstants().neonBlue,
        size: size ?? 36,
      ),
    );
  }
}
