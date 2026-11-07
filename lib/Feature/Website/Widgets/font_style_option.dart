import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class FontStyleOption extends StatelessWidget {
  const FontStyleOption({
    super.key,
    required this.titleAndValue,
    required this.isSelected,
    required this.description,
  });

  final String titleAndValue;
  final String description;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: titleAndValue,
      activeColor: AppConstants().neonBlue,
      tileColor: AppTheme().fillColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
      subtitle: Text(
        isSelected ? AppLocalization.of(context).currentSelection : description,
        style: AppText()
            .regular14(context)
            .copyWith(
              color: isSelected ? AppConstants().neonBlue : null,
            ),
      ),
      title: Text(
        titleAndValue,
        style: AppText().bold20(context).copyWith(fontFamily: titleAndValue),
      ),
    );
  }
}
