class PlaceModel {
  final String id;
  final String name;
  final double lng;
  final double lat;
  final String address;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.lng,
    required this.lat,
    required this.address,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['place_id'] as String,
      name: json['name'] as String,
      lng: json['geometry']['location']['lng'] as double,
      lat: json['geometry']['location']['lat'] as double,
      address: json['formatted_address'] as String,
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'lng': lng,
      'lat': lat,
      'address': address,
    };
  }

  Map<String, dynamic> toResult() {
    return {
      'lng': lng,
      'lat': lat,
      'address': address,
    };
  }
}
