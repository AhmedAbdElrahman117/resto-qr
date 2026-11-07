import 'package:flutter/material.dart';

class ConstraintItem {
  final String title;
  final RegExp regExp;
  ValueNotifier<bool?> value;

  ConstraintItem({
    required this.title,
    required this.regExp,
  }) : value = ValueNotifier(null);
}
