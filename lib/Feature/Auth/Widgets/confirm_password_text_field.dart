import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/toggle_password_button.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.onFieldSubmitted,
    required this.passwordController,
    this.onChanged,
  });

  final TextEditingController controller;
  final TextEditingController passwordController;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  // if you finished the form and want to perform an action
  final void Function()? onFieldSubmitted;

  final void Function(String value)? onChanged;

  @override
  State<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomTextField(
      controller: widget.controller,
      prefixIcon: Icons.lock,
      labelText: l10n.confirmPassword,
      hintText: l10n.reenterTheSamePassword,
      focusNode: widget.focusNode,
      nextFocus: widget.nextFocus,
      obsecureText: showPassword,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      suffix: TogglePasswordButton(
        showPassword: showPassword,
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.passwordConfirmationRequired;
        } else if (widget.passwordController.text.trim() != value.trim()) {
          return l10n.passwordsNotIdentical;
        }
        return null;
      },
    );
  }
}
