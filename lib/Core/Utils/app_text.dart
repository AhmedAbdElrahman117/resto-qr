import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class AppText {
  AppText._();
  static final AppText instance = AppText._();
  factory AppText() => instance;

  // --- 1. Responsive Logic ---
  /// Calculates font size based on screen width but ensures it
  /// never deviates more than 2px from the original design size.
  double _responsiveSize(BuildContext context, double baseSize) {
    // 1. Calculate scale factor (based on standard mobile width of ~375)
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375.0;

    // 2. Apply scale
    double scaledSize = baseSize * scaleFactor;

    // 3. Clamp: Ensure it is never < (base - 2) or > (base + 2)
    return scaledSize.clamp(baseSize - 2.0, baseSize + 2.0);
  }

  // --- 2. Font Family Logic ---
  /// Returns the correct TextStyle with the font family based on Locale
  TextStyle _baseStyle(
    BuildContext context, {
    required double size,
    required FontWeight weight,
    Color? color,
  }) {
    // Calculate final size with your clamping rule
    double finalSize = _responsiveSize(context, size);

    // Common style properties
    final style = TextStyle(
      fontSize: finalSize,
      fontWeight: weight,
      color: color ?? AppTheme().primaryText(context),
    );

    // Return Cairo for Arabic, Inter for everything else
    // We use apply() to merge the GoogleFont with our custom size/color
    return style;
  }

  // H1: Dashboard Welcome (24pt)
  TextStyle dashboardWelcome(BuildContext context) {
    return _baseStyle(
      context,
      size: 24,
      weight: FontWeight.bold,
      color: AppTheme().primaryText(context),
    );
  }

  // H2: Section Titles (20pt)
  TextStyle sectionTitle(BuildContext context) {
    return _baseStyle(
      context,
      size: 20, // 20
      weight: FontWeight.w600, // Semi-Bold
      color: AppTheme().primaryText(context),
    );
  }

  // Body Text (16pt)
  TextStyle body(BuildContext context) {
    return _baseStyle(
      context,
      size: 16,
      weight: FontWeight.normal,
      color: AppTheme().primaryText(context),
    );
  }

  // Price Highlights (16pt, Bold, Blue)
  TextStyle priceHighlight(BuildContext context) {
    return _baseStyle(
      context,
      size: 16,
      weight: FontWeight.bold,
      color: const Color(0xFF33B1FF),
    );
  }

  // Captions / Small Text (14pt, Grey)
  TextStyle caption(BuildContext context) {
    return _baseStyle(
      context,
      size: 14,
      weight: FontWeight.normal,
      color: AppTheme().secondaryText(context),
    );
  }

  // Extra Small Helper (12pt) - Good for timestamps or tiny tags
  TextStyle smallTag(BuildContext context) {
    return _baseStyle(
      context,
      size: 12,
      weight: FontWeight.normal,
      color: AppTheme().secondaryText(context),
    );
  }

  // ==========================================================
  // SIZE 14 (Normal / Standard)
  // ==========================================================
  TextStyle regular12(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 12,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle regular14(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 14,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold14(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 14,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold14(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 14,
      weight: FontWeight.bold,
      color: color,
    );
  }

  // ==========================================================
  // SIZE 16 (Body / Standard)
  // ==========================================================

  TextStyle regular16(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 16,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold16(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 16,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold16(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 16,
      weight: FontWeight.bold,
      color: color,
    );
  }

  // ==========================================================
  // SIZE 18 (Large Body / Subtitles)
  // ==========================================================

  TextStyle regular18(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 18,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold18(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 18,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold18(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 18,
      weight: FontWeight.bold,
      color: color,
    );
  }

  // ==========================================================
  // SIZE 20 (Section Titles)
  // ==========================================================

  TextStyle regular20(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 20,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold20(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 20,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold20(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 20,
      weight: FontWeight.bold,
      color: color,
    );
  }

  // ==========================================================
  // SIZE 22 (Headlines)
  // ==========================================================

  TextStyle regular22(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 22,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold22(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 22,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold22(BuildContext context, [Color? color]) {
    return _baseStyle(context, size: 22, weight: FontWeight.bold, color: color);
  }

  // ==========================================================
  // SIZE 24 (Dashboard Welcome)
  // ==========================================================

  TextStyle regular24(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 24,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold24(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 24,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold24(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 24,
      weight: FontWeight.bold,
      color: color,
    );
  }

  // ==========================================================
  // SIZE 26 (Large Display)
  // ==========================================================

  TextStyle regular26(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 26,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold26(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 26,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold26(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 26,
      weight: FontWeight.bold,
      color: color,
    );
  }

  // ==========================================================
  // SIZE 28 (Hero / Giant Headers)
  // ==========================================================

  TextStyle regular28(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 28,
      weight: FontWeight.normal,
      color: color,
    );
  }

  TextStyle semiBold28(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 28,
      weight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle bold28(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 28,
      weight: FontWeight.bold,
      color: color,
    );
  }

  TextStyle bold32(BuildContext context, [Color? color]) {
    return _baseStyle(
      context,
      size: 32,
      weight: FontWeight.bold,
      color: color,
    );
  }
}
