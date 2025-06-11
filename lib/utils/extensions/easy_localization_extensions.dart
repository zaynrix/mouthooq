import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:easy_localization/easy_localization.dart';
import '../../resources/constants/supported_locales.dart';

extension EasyLocalizationExtensions on BuildContext {
  bool get isRTL => SupportedLocales.isRTL(locale.languageCode);

  String get languageCode => locale.languageCode;

  String get languageName => SupportedLocales.getLanguageName(languageCode);

  TextDirection get textDirection =>
      isRTL ? TextDirection.RTL : TextDirection.LTR;

  TextAlign get textAlign =>
      isRTL ? TextAlign.right : TextAlign.left;
}