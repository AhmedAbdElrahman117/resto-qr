class UserNotificationSettings {
  bool newVisits;
  bool appUpdates;

  UserNotificationSettings({
    required this.newVisits,
    required this.appUpdates,
  });

  factory UserNotificationSettings.fromJson(Map<String, dynamic> json) =>
      UserNotificationSettings(
        newVisits: json['newVisits'] as bool,
        appUpdates: json['appUpdates'] as bool,
      );

  factory UserNotificationSettings.empty() => UserNotificationSettings(
    newVisits: false,
    appUpdates: true,
  );

  factory UserNotificationSettings.fromMap(Map<String, dynamic> map) {
    return UserNotificationSettings(
      newVisits: map['newVisits'] as bool,
      appUpdates: map['appUpdates'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newVisits': newVisits,
      'appUpdates': appUpdates,
    };
  }

  UserNotificationSettings copyWith({
    bool? newVisits,
    bool? appUpdates,
  }) {
    return UserNotificationSettings(
      newVisits: newVisits ?? this.newVisits,
      appUpdates: appUpdates ?? this.appUpdates,
    );
  }
}
