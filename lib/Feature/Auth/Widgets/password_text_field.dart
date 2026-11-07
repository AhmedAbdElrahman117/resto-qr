import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/toggle_password_button.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  // if you finished the form and want to perform an action
  final void Function()? onFieldSubmitted;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomTextField(
      controller: widget.controller,
      prefixIcon: Icons.lock,
      labelText: l10n.password,
      obsecureText: showPassword,
      focusNode: widget.focusNode,
      nextFocus: widget.nextFocus,
      hintText: l10n.enterYourPassword,
      onFieldSubmitted: widget.onFieldSubmitted,
      suffix: TogglePasswordButton(
        showPassword: showPassword,
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
      ),
      onChanged: widget.onChanged,
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.passwordRequired;
            }
            return null;
          },
    );
  }
}
