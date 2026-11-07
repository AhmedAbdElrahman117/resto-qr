class ItemModel {
  final String? id;
  final String? categoryID;
  final String? restaurantID;
  final String? ownerID;
  final String name;
  final String description;
  final String price;
  final List<String> imageURL;
  final String? discount;
  final String? discountPercent;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  final int viewsCount;
  final List<String>? ingredients;
  bool isVisible;

  ItemModel({
    this.id,
    this.categoryID,
    this.restaurantID,
    this.ownerID,
    required this.name,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.isVisible,
    this.createdAt,
    this.expiresAt,
    this.viewsCount = 0,
    this.discount,
    this.discountPercent,
    this.ingredients,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryID,
      'restaurant_id': restaurantID,
      'owner_id': ownerID,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageURL,
      'created_at': createdAt?.toIso8601String(),
      'views_count': viewsCount,
      'is_visible': isVisible,
      'discount': discount,
      'discount_percent': discountPercent,
      'ingredients': ingredients,
    };
  }

  Map<String, dynamic> toUpdateRpc() => {
    'p_id': id,
    'p_name': name,
    'p_description': description,
    'p_price': price,
    'p_image_urls': imageURL,
    'p_is_visible': isVisible,
    'p_discount': discount,
    'p_expires_at': expiresAt?.toIso8601String(),
    'p_ingredients': ingredients,
  };

  Map<String, dynamic> toRpc() => {
    'p_category_id': categoryID,
    'p_restaurant_id': restaurantID,
    'p_owner_id': ownerID,
    'p_name': name,
    'p_description': description,
    'p_price': price,
    'p_image_url': imageURL,
    'p_is_visible': isVisible,
    'p_ingredients': ingredients,
  };

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    DateTime? parsedExpiresAt = map['expires_at'] != null
        ? DateTime.parse(map['expires_at'] as String)
        : null;
    bool isExpired =
        parsedExpiresAt != null && parsedExpiresAt.isBefore(DateTime.now());

    return ItemModel(
      id: map['id'] as String,
      categoryID: map['category_id'] as String,
      restaurantID: map['restaurant_id'] as String,
      ownerID: map['owner_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      imageURL: List<String>.from(map['image_urls'] as List<dynamic>),
      createdAt: DateTime.parse(map['created_at'] as String),
      viewsCount: map['views_count'] as int,
      isVisible: map['is_visible'] as bool? ?? true,
      discount: isExpired ? null : map['discount'] as String?,
      expiresAt: isExpired ? null : parsedExpiresAt,
      discountPercent: isExpired ? null : map['discount_percent'] as String?,
      ingredients: map['ingredients'] != null
          ? List<String>.from(map['ingredients'] as List<dynamic>)
          : null,
    );
  }

  ItemModel copyWith({
    String? id,
    String? categoryID,
    String? restaurantID,
    String? ownerID,
    String? name,
    String? description,
    String? price,
    List<String>? imageURL,
    DateTime? createdAt,
    int? viewsCount,
    bool? isVisible,
    String? Function()? discount,
    String? Function()? discountPercent,
    DateTime? Function()? expiresAt,
    List<String>? ingredients,
  }) {
    return ItemModel(
      id: id ?? this.id,
      categoryID: categoryID ?? this.categoryID,
      restaurantID: restaurantID ?? this.restaurantID,
      ownerID: ownerID ?? this.ownerID,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageURL: imageURL ?? this.imageURL,
      createdAt: createdAt ?? this.createdAt,
      viewsCount: viewsCount ?? this.viewsCount,
      isVisible: isVisible ?? this.isVisible,
      discount: discount != null ? discount() : this.discount,
      expiresAt: expiresAt != null ? expiresAt() : this.expiresAt,
      discountPercent: discountPercent != null
          ? discountPercent()
          : this.discountPercent,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  ItemModel mergeImage(List<String> newImageURLs) {
    var mergedImages = List<String>.from(imageURL)..addAll(newImageURLs);
    return copyWith(imageURL: mergedImages);
  }
}

class EmptyItemModel extends ItemModel {
  EmptyItemModel()
    : super(
        id: '',
        categoryID: '',
        restaurantID: '',
        ownerID: '',
        name: 'Empty Item',
        description: 'This is a placeholder item.',
        price: '19.99',
        imageURL: ['http:'],
        isVisible: true,
      );
}
