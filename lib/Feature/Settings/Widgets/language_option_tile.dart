import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Feature/Settings/Models/language_model.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.groupValue,
    required this.language,
  });

  final LanguageModel language;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: language.code,
      title: Text(language.name, style: AppText().bold16(context)),
      subtitle: Text(
        isSelected()
            ? AppLocalization.of(context).currentSelection
            : AppLocalization.of(context).language,
        style: AppText()
            .caption(context)
            .copyWith(
              color: isSelected() ? AppConstants().neonBlue : null,
            ),
      ),
      secondary: Image.asset(language.flag, width: 40, height: 40),
      tileColor: AppTheme().fillColor(context),
      selected: isSelected(),
      selectedTileColor: AppConstants().neonBlue.withValues(alpha: 0.1),
      activeColor: AppConstants().neonBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected()
              ? AppConstants().neonBlue
              : AppTheme().borderColor(context),
          width: 2,
        ),
      ),
    );
  }

  bool isSelected() => language.code == groupValue;
}
