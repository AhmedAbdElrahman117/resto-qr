import 'package:flutter/material.dart';

class MenuThemeModel {
  final String? id;
  final String? menuID;
  final Color primaryColor;
  final Color backgroundColor;
  final String fontFamily;
  final int cardRadius;
  final int cardElevation;
  final DateTime? createdAt;

  MenuThemeModel({
    this.id,
    this.menuID,
    this.primaryColor = const Color(0xFF0EA5E9),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.fontFamily = 'Roboto',
    this.cardRadius = 12,
    this.cardElevation = 12,
    this.createdAt,
  });

  factory MenuThemeModel.fromMap(Map<String, dynamic> map) {
    return MenuThemeModel(
      id: map['id'],
      menuID: map['menu_id'],
      primaryColor: fromHex(map['primary_color']),
      backgroundColor: fromHex(map['background_color']),
      fontFamily: map['font_family'],
      cardRadius: map['card_radius'],
      cardElevation: map['card_elevation'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'menu_id': menuID,
      'primary_color': toHex(primaryColor),
      'background_color': toHex(backgroundColor),
      'font_family': fontFamily,
      'card_radius': cardRadius,
      'card_elevation': cardElevation,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  String toHex(Color color, {bool includeAlpha = true}) {
    final hex = color
        .toARGB32()
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
    return '#${includeAlpha ? hex : hex.substring(2)}';
  }

  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.parse(hex, radix: 16));
  }

  MenuThemeModel copyWith({
    String? id,
    String? menuID,
    Color? primaryColor,
    Color? backgroundColor,
    String? fontFamily,
    int? cardRadius,
    int? cardElevation,
    DateTime? createdAt,
  }) {
    return MenuThemeModel(
      id: id ?? this.id,
      menuID: menuID ?? this.menuID,
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      cardRadius: cardRadius ?? this.cardRadius,
      cardElevation: cardElevation ?? this.cardElevation,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}