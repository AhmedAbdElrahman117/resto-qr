import 'package:resto_qr/Feature/Menu/Models/item_model.dart';

class OfferModel {
  final int? id;
  final String menuId;
  final String restaurantId;
  final String ownerId;
  final List<ItemModel> items;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  bool isVisible;
  final int viewsCount;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime? createdAt;

  OfferModel({
    this.id,
    required this.menuId,
    required this.restaurantId,
    required this.ownerId,
    required this.items,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.createdAt,
    this.isVisible = true,
    this.viewsCount = 0,
    this.startsAt,
    this.endsAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as int,
      menuId: json['menu_id'] as String,
      restaurantId: json['restaurant_id'] as String,
      ownerId: json['owner_id'] as String,
      items: List<ItemModel>.from(
        (json['items'] as List).map((e) => ItemModel.fromMap(e)),
      ),
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      imageUrl: json['image_url'] as String,
      isVisible: json['is_visible'] as bool? ?? true,
      viewsCount: json['views_count'] as int? ?? 0,
      startsAt: json['starts_at'] != null
          ? DateTime.parse(json['starts_at'] as String)
          : null,
      endsAt: json['ends_at'] != null
          ? DateTime.parse(json['ends_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menu_id': menuId,
      'restaurant_id': restaurantId,
      'owner_id': ownerId,
      'items': items.map((item) => item.toMap()).toList(),
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_visible': isVisible,
      'views_count': viewsCount,
      'starts_at': startsAt?.toIso8601String(),
      'ends_at': endsAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toRpc() {
    return {
      'p_menu_id': menuId,
      'p_restaurant_id': restaurantId,
      'p_owner_id': ownerId,
      'p_item_ids': items.map((item) => item.id).toList(),
      'p_name': name,
      'p_description': description,
      'p_price': price,
      'p_image_url': imageUrl,
      'p_is_visible': isVisible,
      'p_starts_at': startsAt?.toIso8601String(),
      'p_ends_at': endsAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toUpdateRpc() {
    return {
      'p_offer_id': id,
      'p_item_ids': items.map((item) => item.id).toList(),
      'p_name': name,
      'p_description': description,
      'p_price': price,
      'p_image_url': imageUrl,
      'p_is_visible': isVisible,
      'p_starts_at': startsAt?.toIso8601String(),
      'p_ends_at': endsAt?.toIso8601String(),
    };
  }

  OfferModel copyWith({
    int? id,
    String? menuId,
    String? restaurantId,
    String? ownerId,
    List<ItemModel>? items,
    String? name,
    String? description,
    String? price,
    String? imageUrl,
    bool? isVisible,
    int? viewsCount,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  }) {
    return OfferModel(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      restaurantId: restaurantId ?? this.restaurantId,
      ownerId: ownerId ?? this.ownerId,
      items: items ?? this.items,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isVisible: isVisible ?? this.isVisible,
      viewsCount: viewsCount ?? this.viewsCount,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EmptyOfferModel extends OfferModel {
  EmptyOfferModel()
    : super(
        id: 0,
        menuId: '',
        restaurantId: '',
        ownerId: '',
        items: [
          EmptyItemModel(),
          EmptyItemModel(),
          EmptyItemModel(),
        ],
        name: 'Dummy Offer',
        description: 'savjakvhakdijvioahvjioahdvoiahduivhaohvuiahuiovhiuvhadoh',
        price: '250',
        imageUrl: '',
        isVisible: true,
        viewsCount: 55,
        startsAt: DateTime.now().add(const Duration(days: 5)),
        endsAt: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      );
}
