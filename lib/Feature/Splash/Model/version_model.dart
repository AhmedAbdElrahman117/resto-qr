class VersionModel {
  final String id;
  final String version;
  final String url;
  final DateTime createdAt;
  final bool isMandatory;

  VersionModel({
    required this.id,
    this.version = '1.5',
    required this.createdAt,
    required this.isMandatory,
    required this.url,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      id: json['id'] as String,
      version: json['version'] as String,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isMandatory: json['mandatory'] as bool,
    );
  }
}
