import 'package:flutter/material.dart';

enum SupportedLanguage {
  english('en', 'English', 'English', '🇺🇸', false),
  arabic('ar', 'العربية', 'Arabic', '🇸🇦', true);

  const SupportedLanguage(
      this.code,
      this.nativeName,
      this.englishName,
      this.flag,
      this.isRTL
      );

  /// ISO 639-1 language code ('en' or 'ar')
  final String code;

  /// Language name in its native script ('English' or 'العربية')
  final String nativeName;

  /// Language name in English ('English' or 'Arabic')
  final String englishName;

  /// Flag emoji representing the language
  final String flag;

  /// Whether this language uses right-to-left text direction
  final bool isRTL;

  /// Get SupportedLanguage from language code
  static SupportedLanguage fromCode(String code) {
    switch (code.toLowerCase()) {
      case 'ar':
        return SupportedLanguage.arabic;
      case 'en':
      default:
        return SupportedLanguage.english; // Default fallback
    }
  }

  /// Get all supported language codes
  static List<String> get allCodes => ['en', 'ar'];

  /// Check if a language code is supported
  static bool isSupported(String code) {
    return allCodes.contains(code.toLowerCase());
  }

  /// Check if a language code is RTL
  static bool isRTLCode(String code) {
    return code.toLowerCase() == 'ar';
  }

  /// Get language display name (native name + English name)
  String get displayName {
    if (this == SupportedLanguage.english) {
      return nativeName; // Just "English" for English
    }
    return '$nativeName ($englishName)'; // "العربية (Arabic)" for Arabic
  }

  /// Get language with flag
  String get nameWithFlag => '$flag $nativeName';

  /// Get full display with flag and English name
  String get fullDisplayName {
    if (this == SupportedLanguage.english) {
      return '$flag $nativeName';
    }
    return '$flag $nativeName ($englishName)';
  }

  /// Check if this is the default language
  bool get isDefault => this == SupportedLanguage.english;

  /// Get text direction for this language
  TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;

  /// Get the opposite language (English ↔ Arabic)
  SupportedLanguage get opposite {
    return this == SupportedLanguage.english
        ? SupportedLanguage.arabic
        : SupportedLanguage.english;
  }

  @override
  String toString() => code;
}

// Helper extension for easy usage
extension SupportedLanguageExtension on SupportedLanguage {
  /// Convert to Flutter Locale
  Locale get locale => Locale(code);

  /// Get the opposite text direction
  TextDirection get oppositeDirection =>
      isRTL ? TextDirection.ltr : TextDirection.rtl;

  /// Check if this is Arabic
  bool get isArabic => this == SupportedLanguage.arabic;

  /// Check if this is English
  bool get isEnglish => this == SupportedLanguage.english;
}