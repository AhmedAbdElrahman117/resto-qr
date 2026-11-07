import 'package:flutter/material.dart';

class ProfileNotifier extends ValueNotifier<bool> {
  ProfileNotifier({
    required this.userName,
    required this.restaurantName,
    required this.phoneNumber,
  }) : super(false);

  final String userName;
  final String restaurantName;
  final String phoneNumber;

  bool isNameValid = false;
  bool isRestNameValid = false;
  bool isNumberValid = false;

  void validName(String name) {
    isNameValid = userName != name;
    _updateValidity();
  }

  void validRestName(String name) {
    isRestNameValid = restaurantName != name;
    _updateValidity();
  }

  void validNumber(String number, bool isValid) {
    isNumberValid = phoneNumber != number && isValid;
    _updateValidity();
  }

  void _updateValidity() =>
      value = isRestNameValid || isNumberValid || isNameValid;
}
