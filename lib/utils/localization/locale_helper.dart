import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../resources/constants/supported_locales.dart';

class LocaleHelper {
  static Future<void> changeLanguage(BuildContext context, String languageCode) async {
    final locale = Locale(languageCode);
    if (SupportedLocales.all.contains(locale)) {
      await context.setLocale(locale);
    }
  }

  static String getCurrentLanguageName(BuildContext context) {
    return SupportedLocales.getLanguageName(context.locale.languageCode);
  }

  static bool isCurrentLanguageRTL(BuildContext context) {
    return SupportedLocales.isRTL(context.locale.languageCode);
  }

  static List<Locale> getAvailableLocales() {
    return SupportedLocales.all;
  }

  static EdgeInsetsGeometry getDirectionalPadding(
      BuildContext context, {
        double left = 0,
        double top = 0,
        double right = 0,
        double bottom = 0,
      }) {
    if (SupportedLocales.isRTL(context.locale.languageCode)) {
      return EdgeInsets.only(
        left: right,
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
}