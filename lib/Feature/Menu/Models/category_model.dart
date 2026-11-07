class CategoryModel {
  String? id;
  String? menuID;
  final String name;
  final String? imageURL;
  final DateTime? createdAt;
  int itemsCount;
  bool isVisible;

  CategoryModel({
    this.id,
    this.menuID,
    required this.name,
    this.imageURL,
    this.createdAt,
    this.itemsCount = 0,
    this.isVisible = true,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      menuID: map['menu_id'] as String,
      imageURL: map['image_url'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      isVisible: map['is_visible'] as bool? ?? true,
      itemsCount: map['items_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'menu_id': menuID,
      'image_url': imageURL,
      'created_at': createdAt?.toIso8601String(),
      'is_visible': isVisible,
      'items_count': itemsCount,
    };
  }

  Map<String, dynamic> toRpc({bool addID = false}) {
    var data = {
      'p_name': name,
      'p_menu_id': menuID,
      'p_image_url': imageURL,
      'p_is_visible': isVisible,
    };
    if (addID) {
      data['p_id'] = id;
    }

    return data;
  }

  Map<String, dynamic> toUpdateRpc() {
    return {
      'p_id': id,
      'p_name': name,
      'p_image_url': imageURL,
      'p_is_visible': isVisible,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? menuID,
    String? imageURL,
    DateTime? createdAt,
    bool? isVisible,
    int? itemsCount,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      menuID: menuID ?? this.menuID,
      imageURL: imageURL ?? this.imageURL,
      createdAt: createdAt ?? this.createdAt,
      isVisible: isVisible ?? this.isVisible,
      itemsCount: itemsCount ?? this.itemsCount,
    );
  }
}

class EmptyCategoryModel extends CategoryModel {
  EmptyCategoryModel()
    : super(
        id: null,
        menuID: null,
        name: 'Empty Category',
        imageURL: null,
        createdAt: null,
        itemsCount: 0,
        isVisible: true,
      );
}
