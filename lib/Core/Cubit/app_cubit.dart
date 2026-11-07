import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:resto_qr/Core/Models/app_settings.dart';
import 'package:resto_qr/Core/Models/user_notification_settings.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';

class AppCubit extends HydratedCubit<AppSettings> with SafeCubit {
  AppCubit()
    : super(
        AppSettings(
          mode: checkTheme(),
          languageCode: checkLanguage(),
          showOnboarding: true,
          notificationSettings: UserNotificationSettings.empty(),
        ),
      ) {
    checkIsUnderMaintenance();
  }

  StreamSubscription? _maintenanceSubscription;

  static ThemeMode checkTheme() =>
      PlatformDispatcher.instance.platformBrightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  static String checkLanguage() {
    var deviceLanguage = getDeviceLanguage();
    if (isLanguageAvailable(deviceLanguage)) {
      return deviceLanguage;
    }
    return 'en';
  }

  static bool isLanguageAvailable(String languageCode) =>
      AppLocalization.isLanguageSupported(languageCode);

  static String getDeviceLanguage() =>
      PlatformDispatcher.instance.locale.languageCode;

  void updateNotificationSettings({bool? newVisits, bool? appUpdates}) {
    var newSettings = state.notificationSettings.copyWith(
      newVisits: newVisits,
      appUpdates: appUpdates,
    );

    safeEmit(state.copyWith(notificationSettings: newSettings));
  }

  void toggleTheme() => safeEmit(
    state.copyWith(
      mode: state.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    ),
  );

  void changeLanguage({
    required String languageCode,
    required String languageName,
  }) => safeEmit(
    state.copyWith(languageCode: languageCode, languageName: languageName),
  );

  void disableOnboarding() => safeEmit(
    state.copyWith(showOnboarding: false),
  );

  Future<void> checkIsUnderMaintenance() async {
    final completer = Completer<void>();

    _maintenanceSubscription = SupabaseDb()
        .getStream(table: 'maintenance')
        .listen(
          (res) {
            if (res.isNotEmpty) {
              bool maintenance = res.first['is_under_maintenance'];

              safeEmit(state.copyWith(isUnderMaintenance: maintenance));
            }

            if (!completer.isCompleted) {
              completer.complete();
            }
          },
          onError: (e) {
            safeEmit(state.copyWith(isUnderMaintenance: false));
            if (!completer.isCompleted) {
              completer.complete();
            }
          },
        );

    return completer.future.timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        if (!completer.isCompleted) completer.complete();
      },
    );
  }

  @override
  AppSettings? fromJson(Map<String, dynamic> json) => AppSettings(
    mode: ThemeMode.values.byName(json['isDarkMode'] as String),
    languageCode: json['currentLanguage'] as String,
    languageName: json['languageName'] as String?,
    showOnboarding: json['showOnboarding'] as bool,
    notificationSettings: UserNotificationSettings.fromMap(
      json['notificationSettings'] as Map<String, dynamic>,
    ),
  );

  @override
  Map<String, dynamic>? toJson(AppSettings state) => {
    'isDarkMode': state.mode.name,
    'showOnboarding': state.showOnboarding,
    'currentLanguage': state.languageCode,
    'languageName': state.languageName,
    'notificationSettings': state.notificationSettings.toMap(),
  };

  @override
  Future<void> close() {
    _maintenanceSubscription?.cancel();
    _maintenanceSubscription = null;
    return super.close();
  }
}
