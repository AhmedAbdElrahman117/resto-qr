import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    this.onCompleted,
    this.validator,
    required this.controller,
  });

  final void Function(String value)? onCompleted;
  final String? Function(String? value)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      hapticFeedbackType: .mediumImpact,
      length: 4,
      mainAxisAlignment: .spaceEvenly,
      defaultPinTheme: pinTheme(
        context,
        borderColor: AppTheme().borderColor(context),
      ),
      focusedPinTheme: pinTheme(
        context,
        borderColor: AppTheme().shadowColor(context),
        boxShadow: [
          BoxShadow(
            color: AppTheme().shadowColor(context),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      onCompleted: onCompleted,
      validator: validator,
    );
  }

  PinTheme pinTheme(
    BuildContext context, {
    required Color borderColor,
    List<BoxShadow>? boxShadow,
  }) {
    return PinTheme(
      textStyle: AppText().bold22(context),
      margin: .symmetric(horizontal: 12),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        color: AppTheme().fillColor(context),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: boxShadow,
      ),
    );
  }
}
