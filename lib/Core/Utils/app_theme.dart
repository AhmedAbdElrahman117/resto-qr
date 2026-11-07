import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';

class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  factory AppTheme() => _instance;

  bool isDark(BuildContext context, [bool watch = true]) => watch
      ? context.watch<AppCubit>().state.mode == ThemeMode.dark
      : context.read<AppCubit>().state.mode == ThemeMode.dark;
  // true;

  Color primaryBackground(BuildContext context, [bool watch = true]) =>
      isDark(context, watch)
      ? const Color(0xFF101C22)
      : const Color(0xFFF8FAFC);

  Color secondaryBackground(BuildContext context, [bool watch = true]) =>
      isDark(context, watch)
      ? const Color(0xFF161B22)
      : const Color(0xFFFFFFFF);

  Color primaryText(BuildContext context, [bool watch = true]) =>
      isDark(context, watch)
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF1E293B);

  Color secondaryText(BuildContext context, [bool watch = true]) =>
      isDark(context, watch)
      ? const Color(0xFF8B949E)
      : const Color(0xFF64748B);

  Color borderColor(BuildContext context, [bool watch = true]) =>
      isDark(context, watch)
      ? const Color(0xFF30363D)
      : const Color(0xFFE2E8F0);

  Color shadowColor(BuildContext context) =>
      const Color(0xFF2BADEE).withValues(alpha: 0.7);

  Color naturalShadowColor(BuildContext context) => Colors.black;

  Color fillColor(BuildContext context, [bool watch = true]) =>
      isDark(context, watch) ? Color(0xFF1C2E36) : Colors.white;

  Color adaptiveIconColor(BuildContext context, [bool watch = true]) =>
      isDark(context, watch) ? Colors.white : Colors.black;

  Color iconColor(BuildContext context) => Color(0xFF64748B);

  Color sheetColor(BuildContext context, [bool watch = true]) =>
      isDark(context, watch)
      ? const Color(0xFF1C2E36)
      : const Color(0xFFFFFFFF);

  ThemeData themeData(BuildContext context, Brightness brightness) => ThemeData(
    scaffoldBackgroundColor: AppTheme().primaryBackground(context),
    brightness: brightness,
    cardTheme: CardThemeData(
      color: AppTheme().secondaryBackground(context),
      shadowColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(16),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme().primaryBackground(context),
      foregroundColor: AppTheme().primaryText(context),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const .all(16),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(
          color: AppTheme().borderColor(context),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppConstants().neonBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppConstants().errorRed, width: 1.5),
      ),
    ),
    switchTheme: SwitchThemeData(
      // Thumb color (The circle)
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white; // Usually white thumb on blue track looks best
        }
        return Colors.grey.shade400;
      }),
      // Track color (The background bar)
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppConstants().neonBlue; // ON: #33B1FF
        }
        return AppTheme().borderColor(context); // OFF: #30363D
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}
