import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:resto_qr/generated/l10n.dart';

class AppLocalization {
  AppLocalization._();

  static const LocalizationsDelegate<S> delegate = S.delegate;

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static List<Locale> supportedLocales = S.delegate.supportedLocales;

  // ----------------------------------------------------------
  // Accessors
  // ----------------------------------------------------------

  static S of(BuildContext context) => S.of(context);

  static S get current => S.current;

  // ----------------------------------------------------------
  // Utils
  // ----------------------------------------------------------

  static bool isLanguageSupported(String languageCode) {
    return supportedLocales.any(
      (locale) => locale.languageCode == languageCode,
    );
  }

  static String _localeName([BuildContext? context]) {
    final raw = context != null
        ? Localizations.localeOf(context).toString()
        : Intl.getCurrentLocale();

    // Plain 'ar' uses Western digits in recent intl versions.
    // 'ar_EG' gives Arabic-Indic digits and Egyptian separators.
    final languageCode = raw.split(RegExp('[-_]')).first;
    if (languageCode == 'ar') return 'ar_EG';

    return raw;
  }

  // ----------------------------------------------------------
  // Number localization
  // ----------------------------------------------------------

  static String formatNumber(
    num value, {
    BuildContext? context,
    int? decimalDigits,
  }) {
    final format = NumberFormat.decimalPattern(_localeName(context));
    if (decimalDigits != null) {
      format
        ..minimumFractionDigits = decimalDigits
        ..maximumFractionDigits = decimalDigits;
    }
    return format.format(value);
  }

  static String formatPercent(
    num value, {
    BuildContext? context,
    int decimalDigits = 0,
  }) {
    final format = NumberFormat.percentPattern(_localeName(context))
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return format.format(value);
  }

  static String formatCompact(num value, {BuildContext? context}) {
    return NumberFormat.compact(locale: _localeName(context)).format(value);
  }

  static num? parseNumber(String source, {BuildContext? context}) {
    try {
      return NumberFormat.decimalPattern(_localeName(context)).parse(source);
    } on FormatException {
      return null;
    }
  }

  static String toLatinDigits(String input) {
    const arabicIndic = '٠١٢٣٤٥٦٧٨٩';
    const easternIndic = '۰۱۲۳۴۵۶۷۸۹';
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      final ch = String.fromCharCode(rune);
      var i = arabicIndic.indexOf(ch);
      if (i == -1) i = easternIndic.indexOf(ch);
      buffer.write(i == -1 ? ch : i.toString());
    }
    return buffer.toString();
  }

  static String toArabicDigits(String input) {
    const latin = '0123456789';
    const arabicIndic = '٠١٢٣٤٥٦٧٨٩';
    final buffer = StringBuffer();
    for (final ch in input.split('')) {
      final i = latin.indexOf(ch);
      buffer.write(i == -1 ? ch : arabicIndic[i]);
    }
    return buffer.toString();
  }

  // ----------------------------------------------------------
  // Currency
  // ----------------------------------------------------------

  static const Map<String, _CurrencyInfo> _currencies = {
    'en': _CurrencyInfo(code: 'USD', symbol: '\$', decimalDigits: 2),
    'ar': _CurrencyInfo(code: 'EGP', symbol: 'ج.م', decimalDigits: 2),
    'de': _CurrencyInfo(code: 'EUR', symbol: '€', decimalDigits: 2),
    'fr': _CurrencyInfo(code: 'EUR', symbol: '€', decimalDigits: 2),
    'es': _CurrencyInfo(code: 'EUR', symbol: '€', decimalDigits: 2),
    'zh': _CurrencyInfo(code: 'CNY', symbol: '¥', decimalDigits: 2),
    'ja': _CurrencyInfo(code: 'JPY', symbol: '¥', decimalDigits: 0),
  };

  static const _CurrencyInfo _fallbackCurrency = _CurrencyInfo(
    code: 'USD',
    symbol: '\$',
    decimalDigits: 2,
  );

  static _CurrencyInfo _currencyFor([BuildContext? context]) {
    final languageCode = context != null
        ? Localizations.localeOf(context).languageCode
        : Intl.getCurrentLocale().split(RegExp('[-_]')).first;
    return _currencies[languageCode] ?? _fallbackCurrency;
  }

  static String formatCurrency(
    num value, {
    BuildContext? context,
    String? symbol,
    int? decimalDigits,
  }) {
    final currency = _currencyFor(context);
    return NumberFormat.currency(
      locale: _localeName(context),
      name: currency.code,
      symbol: symbol ?? currency.symbol,
      decimalDigits: decimalDigits ?? currency.decimalDigits,
    ).format(value);
  }

  /// 05/03/2026
  static String formatDate(DateTime date, {BuildContext? context}) {
    return DateFormat(
      'dd/MM/yyyy',
      _localeName(context),
    ).format(date.toLocal());
  }

  /// 05/03/2026 15:45
  static String formatDateTime(DateTime date, {BuildContext? context}) {
    return DateFormat(
      'd/MM/yyyy hh:mm a',
      _localeName(context),
    ).format(date.toLocal());
  }
}

class _CurrencyInfo {
  final String code;
  final String symbol;
  final int decimalDigits;

  const _CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.decimalDigits,
  });
}
