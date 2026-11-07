import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Models/user_notification_settings.dart';

class AppSettings {
  ThemeMode mode;
  bool showOnboarding;
  String languageCode;
  String? languageName;
  UserNotificationSettings notificationSettings;
  bool isUnderMaintenance;

  AppSettings({
    required this.mode,
    required this.showOnboarding,
    required this.languageCode,
    required this.notificationSettings,
    this.languageName,
    this.isUnderMaintenance = false,
  });

  AppSettings copyWith({
    ThemeMode? mode,
    bool? showOnboarding,
    String? languageCode,
    String? languageName,
    UserNotificationSettings? notificationSettings,
    bool? isUnderMaintenance,
  }) {
    return AppSettings(
      mode: mode ?? this.mode,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      showOnboarding: showOnboarding ?? this.showOnboarding,
      languageCode: languageCode ?? this.languageCode,
      languageName: languageName ?? this.languageName,
      isUnderMaintenance: isUnderMaintenance ?? this.isUnderMaintenance,
    );
  }
}
