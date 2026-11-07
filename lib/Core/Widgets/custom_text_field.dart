import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.prefixIcon,
    required this.labelText,
    required this.hintText,
    this.enabled,
    this.keyboardType,
    this.obsecureText = false,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.suffix,
    this.nextFocus,
    this.maxLines = 1,
    this.onChanged,
    this.disableInteractionOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String labelText;
  final String hintText;
  final bool? enabled;
  final TextInputType? keyboardType;
  final bool? obsecureText;
  final String? Function(String? value)? validator;
  final void Function()? onFieldSubmitted;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Widget? suffix;
  final int? maxLines;
  final void Function(String value)? onChanged;
  final bool? disableInteractionOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      inputFormatters:
          keyboardType == TextInputType.number ||
              keyboardType == TextInputType.numberWithOptions(decimal: true)
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
          : null,
      obscureText: obsecureText ?? false,
      focusNode: focusNode,
      minLines: null,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme().fillColor(context),
        border: OutlineInputBorder(
          borderRadius: .circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: .circular(8),
          borderSide: BorderSide(color: AppConstants().errorRed),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: .circular(8),
        ),
        labelText: labelText,
        alignLabelWithHint: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        prefixIconColor: AppTheme().iconColor(context),
        suffixIcon: Padding(
          padding: const .symmetric(horizontal: 8),
          child: suffix,
        ),
        suffixIconColor: AppTheme().iconColor(context),
        hintText: hintText,
        hintStyle: AppText().caption(context).copyWith(fontSize: 16),
        labelStyle: AppText().caption(context).copyWith(fontSize: 16),
      ),
      canRequestFocus: disableInteractionOnly! ? false : true,
      ignorePointers: disableInteractionOnly! ? true : false,
      textAlignVertical: .top,
      style: AppText()
          .regular16(context)
          .copyWith(
            color: enabled == false ? AppTheme().secondaryText(context) : null,
          ),
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: (value) {
        if (nextFocus != null && focusNode != null) {
          focusNode!.unfocus();
          nextFocus!.requestFocus();
        }
        if (onFieldSubmitted != null) {
          onFieldSubmitted!.call();
        }
      },
      validator: validator,
    );
  }
}
