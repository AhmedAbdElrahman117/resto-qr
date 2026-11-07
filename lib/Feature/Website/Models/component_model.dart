import 'package:flutter/material.dart';

class ComponentModel {
  final String name;
  final String description;
  final String image;
  final Widget preview;
  final Color? color;

  const ComponentModel({
    required this.name,
    required this.description,
    required this.image,
    required this.preview,
    this.color,
  });
}
