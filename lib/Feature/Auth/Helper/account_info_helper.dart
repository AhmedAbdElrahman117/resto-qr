import 'package:flutter/material.dart';
import 'package:resto_qr/Feature/Auth/Helper/constraint_controller.dart';

class AccountInfoHelper {
  final TextEditingController nameController = .new();

  final TextEditingController emailController = .new();
  final TextEditingController phoneController = .new();
  final TextEditingController passwordController = .new();
  final TextEditingController confirmPasswordController = .new();

  final FocusNode nameFocus = .new();
  final FocusNode emailFocus = .new();
  final FocusNode phoneFocus = .new();
  final FocusNode passwordFocus = .new();
  final FocusNode confirmPasswordFocus = .new();

  final GlobalKey<FormState> accountInfo = .new();

  late final ConstraintController constraintController = ConstraintController(
    passwordController: passwordController,
  );

  bool validateFields() =>
      accountInfo.currentState != null &&
      accountInfo.currentState!.validate() &&
      constraintController.allValid();
}
