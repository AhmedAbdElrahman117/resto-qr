import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Feature/Auth/Model/constraint_item.dart';

class ConstraintController {
  final TextEditingController passwordController;
  List<ConstraintItem>? constraints;

  ConstraintController({required this.passwordController, this.constraints}) {
    constraints = [
      ConstraintItem(
        title: '',
        regExp: AppConstants().passwordLength,
      ),
      ConstraintItem(
        title: '',
        regExp: AppConstants().hasNumber,
      ),
      ConstraintItem(
        title: '',
        regExp: AppConstants().hasSpecialChar,
      ),
    ];
  }

  void setTitles(List<String> titles) {
    for (var i = 0; i < titles.length && i < constraints!.length; i++) {
      constraints![i] = ConstraintItem(
        title: titles[i],
        regExp: constraints![i].regExp,
      )..value.value = constraints![i].value.value;
    }
  }

  ConstraintController.custom({
    required this.passwordController,
    required List<ConstraintItem> constraints,
    // ignore: prefer_initializing_formals
  }) : constraints = constraints;

  void checkPassword() {
    String text = passwordController.text;
    for (var e in constraints!.indexed) {
      setValue(e.$1, e.$2.regExp.hasMatch(text));
    }
  }

  bool setValue(int index, bool value) =>
      constraints!.elementAt(index).value.value = value;

  bool allValid() => constraints!.every(
    (element) => element.value.value ?? false,
  );
}
