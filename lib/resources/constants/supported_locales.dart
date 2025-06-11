import 'package:flutter/material.dart';

class SupportedLocales {
  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');
  static const Locale spanish = Locale('es');
  static const Locale french = Locale('fr');
  static const Locale german = Locale('de');

  static const List<Locale> all = [
    english,
    arabic,
    spanish,
    french,
    german,
  ];

  static const Map<String, String> languageNames = {
    'en': 'English',
    'ar': 'العربية',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
  };

  static String getLanguageName(String code) {
    return languageNames[code] ?? 'Unknown';
  }

  static bool isRTL(String languageCode) {
    return ['ar', 'he', 'fa', 'ur'].contains(languageCode);
  }
}