import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static final AppConstants _instance = AppConstants._();

  factory AppConstants() => _instance;

  final Color neonBlue = const Color(0xFF0EA5E9);

  final Color successColor = const Color(0xFF10B981);

  final Color errorRed = const Color(0xFFFF4D4D);

  final Color emptyStateTextColor = const Color(0xFF8B949E);

  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$');

  final RegExp passwordLength = RegExp(r'^.{8,}$');
  final RegExp hasSpecialChar = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
  final RegExp hasNumber = RegExp(r'(?=.*[0-9])');
}
