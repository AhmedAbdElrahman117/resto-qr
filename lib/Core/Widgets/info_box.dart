import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key, required this.info});

  final String info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppTheme().fillColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
      leading: Icon(
        Icons.info_outline_rounded,
        color: AppConstants().neonBlue,
      ),
      subtitle: Text(
        info,
        style: AppText()
            .regular14(context)
            .copyWith(color: AppConstants().neonBlue),
      ),
    );
  }
}
