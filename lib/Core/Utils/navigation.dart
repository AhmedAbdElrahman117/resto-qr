import 'package:flutter/material.dart';

class Navigation {
  Navigation._();

  static Navigation? _instance;

  factory Navigation() => _instance ??= Navigation._();

  Future<dynamic> push(BuildContext context, Widget to) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => to),
    );
  }

  void pop(BuildContext context, [dynamic result]) {
    return Navigator.of(context).pop(result);
  }

  dynamic pushReplacement(BuildContext context, Widget to) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => to),
    );
  }
}
