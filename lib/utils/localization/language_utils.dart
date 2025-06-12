import 'package:flutter/material.dart';
import 'package:mouthooq/utils/enums/supported_language.dart';

class LanguageUtils {
  /// Get device language if supported, otherwise return English
  static SupportedLanguage getDeviceLanguageOrDefault() {
    try {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final deviceCode = deviceLocale.languageCode;

      if (SupportedLanguage.isSupported(deviceCode)) {
        return SupportedLanguage.fromCode(deviceCode);
      }

      return SupportedLanguage.english; // Default fallback
    } catch (e) {
      return SupportedLanguage.english;
    }
  }

  /// Toggle between English and Arabic
  static SupportedLanguage toggle(SupportedLanguage current) {
    return current.opposite;
  }

  /// Get language-specific text alignment
  static TextAlign getTextAlign(SupportedLanguage language, {TextAlign? defaultAlign}) {
    if (language.isRTL) {
      switch (defaultAlign) {
        case TextAlign.left:
          return TextAlign.right;
        case TextAlign.right:
          return TextAlign.left;
        case TextAlign.start:
          return TextAlign.end;
        case TextAlign.end:
          return TextAlign.start;
        default:
          return TextAlign.right; // Default for Arabic
      }
    }
    return defaultAlign ?? TextAlign.left; // Default for English
  }

  /// Get language-specific edge insets (for RTL support)
  static EdgeInsetsGeometry getDirectionalPadding(
      SupportedLanguage language, {
        double left = 0,
        double top = 0,
        double right = 0,
        double bottom = 0,
      }) {
    if (language.isRTL) {
      return EdgeInsets.only(
        left: right,   // Flip left and right
        top: top,
        right: left,
        bottom: bottom,
      );
    }
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  /// Get language statistics
  static Map<String, dynamic> getLanguageStats() {
    return {
      'total_languages': SupportedLanguage.values.length,
      'supported_codes': SupportedLanguage.allCodes,
      'default_language': SupportedLanguage.english.code,
      'rtl_languages': ['ar'],
      'ltr_languages': ['en'],
    };
  }

  /// Format text based on language direction
  static String formatDirectionalText(SupportedLanguage language, String text) {
    if (language.isRTL) {
      // Add RTL mark if needed
      return '\u202B$text\u202C'; // RLE + text + PDF
    }
    return text;
  }
}