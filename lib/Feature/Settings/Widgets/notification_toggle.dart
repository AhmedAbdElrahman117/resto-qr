import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';

class NotificationToggle extends StatelessWidget {
  const NotificationToggle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.initialValue,
    required this.onToggle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final bool initialValue;
  final IconData icon;
  final Function(bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    return CustomSwitchTile(
      title: title,
      subtitle: subtitle,
      initialValue: initialValue,
      color: AppConstants().neonBlue,
      secondry: Container(
        padding: .all(12),
        decoration: BoxDecoration(
          color: AppConstants().neonBlue.withValues(alpha: 0.15),
          borderRadius: .circular(12),
        ),
        child: Icon(icon, color: AppConstants().neonBlue),
      ),
      border: BorderSide(color: AppTheme().borderColor(context), width: 2),
      backgroundColor: AppTheme().fillColor(context),
      onToggle: onToggle,
    );
  }
}
