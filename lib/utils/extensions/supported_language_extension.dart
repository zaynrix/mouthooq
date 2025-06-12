import 'package:flutter/material.dart';
import 'package:mouthooq/utils/enums/supported_language.dart';

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