import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class SettingOptionTile extends StatelessWidget {
  const SettingOptionTile({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.subtitle,
  });

  final void Function()? onTap;
  final String title;
  final String? subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: AppTheme().fillColor(context),
      contentPadding: .symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
      leading: Container(
        padding: .all(12),
        decoration: BoxDecoration(
          color: AppConstants().neonBlue.withValues(alpha: 0.15),
          borderRadius: .circular(12),
        ),
        child: Icon(
          icon,
          color: AppConstants().neonBlue,
        ),
      ),
      title: Text(
        title,
        style: AppText().semiBold14(context),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppText().caption(context),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppConstants().neonBlue,
      ),
    );
  }
}
