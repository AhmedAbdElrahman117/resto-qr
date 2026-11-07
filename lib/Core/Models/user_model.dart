class UserModel {
  final String? id;
  final String userName;
  final String email;
  final String phone;
  final String? restaurantID;
  final String restaurantName;
  final String restaurantAddress;
  final String? restaurantLogoURL;
  final String? restaurantdescription;
  final DateTime? createdAt;
  final String? menuId;
  final String? menuUrl;
  final String? menuTitle;
  final String? themeID;
  final double lat;
  final double lng;

  const UserModel({
    this.id,
    required this.email,
    required this.phone,
    this.restaurantID,
    required this.restaurantName,
    required this.restaurantAddress,
    this.restaurantLogoURL,
    this.restaurantdescription,
    this.createdAt,
    required this.userName,
    this.menuId,
    this.menuUrl,
    this.menuTitle,
    this.themeID,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'user_name': userName,
    'phone': phone,
    'restaurant_name': restaurantName,
    'restaurant_address': restaurantAddress,
    'restaurant_logo_url': restaurantLogoURL,
    'restaurant_description': restaurantdescription,
    'restaurant_id': restaurantID,
    'menu_id': menuId,
    'menu_url': menuUrl,
    'menu_title': menuTitle,
    'theme_id': themeID,
    'created_at': createdAt?.toUtc().toIso8601String(),
    'latitude': lat,
    'longitude': lng,
  };

  Map<String, dynamic> toRpc() => {
    'p_id': id,
    'p_email': email,
    'p_user_name': userName,
    'p_phone': phone,
    'p_restaurant_name': restaurantName,
    'p_restaurant_address': restaurantAddress,
    'p_restaurant_logo_url': restaurantLogoURL,
    'p_restaurant_description': restaurantdescription,
    'p_latitude': lat,
    'p_longitude': lng,
  };

  factory UserModel.fromJson(Map<String, dynamic> user) => UserModel(
    id: user['id'],
    userName: user['user_name'] ?? '',
    email: user['email'],
    phone: user['phone'],
    restaurantName: user['restaurant_name'],
    restaurantAddress: user['restaurant_address'],
    restaurantLogoURL: user['restaurant_logo_url'],
    restaurantdescription: user['restaurant_description'],
    restaurantID: user['restaurant_id'],
    menuId: user['menu_id'],
    menuTitle: user['menu_title'],
    menuUrl: user['menu_url'],
    themeID: user['theme_id'],
    createdAt: user['created_at'] != null
        ? DateTime.parse(user['created_at'])
        : null,
    lat: user['latitude'] ?? 0.0,
    lng: user['longitude'] ?? 0.0,
  );

  UserModel copyWith({
    String? id,
    String? email,
    String? userName,
    String? phone,
    String? restaurantName,
    String? restaurantAddress,
    String? restaurantLogoURL,
    String? restaurantdescription,
    DateTime? createdAt,
    String? menuUrl,
    String? menuTitle,
    double? lat,
    double? lng,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantAddress: restaurantAddress ?? this.restaurantAddress,
      restaurantLogoURL: restaurantLogoURL ?? this.restaurantLogoURL,
      restaurantdescription:
          restaurantdescription ?? this.restaurantdescription,
      menuId: menuId,
      menuUrl: menuUrl ?? this.menuUrl,
      menuTitle: menuTitle ?? this.menuTitle,
      createdAt: createdAt ?? this.createdAt,
      restaurantID: restaurantID,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}

class EmptyUser extends UserModel {
  const EmptyUser()
    : super(
        id: null,
        email: '',
        phone: '',
        restaurantName: 'Unknown',
        restaurantAddress: '',
        userName: 'Unknown User',
        lat: 0.0,
        lng: 0.0,
      );
}
