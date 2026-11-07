import 'dart:math';

import 'package:resto_qr/Core/Utils/assets.dart';

class BannerModel {
  final String id;
  final String menuId;
  final String imageUrl;
  final String? redirectUrl;
  final bool isLive;
  final int interactions;
  final DateTime createdAt;
  final DateTime? expiresAt;

  BannerModel({
    required this.id,
    required this.menuId,
    required this.imageUrl,
    this.redirectUrl,
    required this.isLive,
    required this.interactions,
    required this.createdAt,
    this.expiresAt,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as String,
      menuId: map['menu_id'] as String,
      imageUrl: map['image_url'] as String,
      redirectUrl: map['redirect_url'] as String?,
      isLive: map['is_live'] as bool? ?? true,
      interactions: map['interactions'] as int? ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
      expiresAt: map['expires_at'] != null
          ? DateTime.parse('${map['expires_at']}').toLocal()
          : null,
    );
  }

  factory BannerModel.mock() {
    return BannerModel(
      id: 'mock_id',
      menuId: 'mock_menu_id',
      imageUrl: Assets.imagesOnboarding1,
      redirectUrl: 'https://example.com',
      isLive: true,
      interactions: 42,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    );
  }

  Map<String, dynamic> toAddRPC() {
    return {
      'p_menu_id': menuId,
      'p_image_url': imageUrl,
      'p_redirect_url': redirectUrl,
      'p_is_live': isLive,
      'p_expires_at': expiresAt?.toUtc().toIso8601String(),
    };
  }

  Map<String, dynamic> toUpdateRPC() {
    return {
      'p_banner_id': id,
      'p_image_url': imageUrl,
      'p_redirect_url': redirectUrl,
      'p_is_live': isLive,
      'p_expires_at': expiresAt?.toUtc().toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'menu_id': menuId,
      'image_url': imageUrl,
      'redirect_url': redirectUrl,
      'is_live': isLive,
      'interactions': interactions,
      if (expiresAt != null) 'expires_at': expiresAt!.toUtc().toIso8601String(),
    };
  }

  BannerModel copyWith({
    String? id,
    String? menuId,
    String? imageUrl,
    String? redirectUrl,
    bool? isLive,
    int? interactions,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      imageUrl: imageUrl ?? this.imageUrl,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      isLive: isLive ?? this.isLive,
      interactions: interactions ?? this.interactions,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class EmptyBannerModel extends BannerModel {
  EmptyBannerModel()
    : super(
        id: '',
        menuId: '',
        imageUrl:
            'https://img.freepik.com/free-photo/closeup-shot-beautiful-butterfly-with-interesting-textures-orange-petaled-flower_181624-7640.jpg?semt=ais_hybrid&w=740&q=80',
        redirectUrl: null,
        isLive: true,
        interactions: Random().nextInt(10000 * 100),
        createdAt: DateTime.now(),
        expiresAt: null,
      );
}
