import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  // if you finished the form and want to perform an action
  final void Function()? onFieldSubmitted;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomTextField(
      controller: controller,
      prefixIcon: Icons.email,
      labelText: l10n.email,
      hintText: l10n.enterYourEmail,
      focusNode: focusNode,
      nextFocus: nextFocus,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.emailRequired;
        } else if (!AppConstants().emailRegex.hasMatch(value)) {
          return l10n.invalidEmail;
        }
        return null;
      },
    );
  }
}
