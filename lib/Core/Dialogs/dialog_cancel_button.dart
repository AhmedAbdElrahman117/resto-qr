import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class DialogCancelButton extends StatelessWidget {
  const DialogCancelButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      label: Text(
        AppLocalization.of(context).cancel,
        style: AppText().bold16(context),
      ),
      icon: Icon(
        Icons.close_rounded,
        color: AppTheme().adaptiveIconColor(context),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 1.5,
        ),
        padding: const .symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
