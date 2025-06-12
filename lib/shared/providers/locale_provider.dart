import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouthooq/utils/logging/app_logger.dart';
import '../../utils/enums/supported_language.dart';
import '../../services/storage_service.dart';
import '../../services/storage_keys.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en', '')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    try {
      final savedLanguage = await StorageService.getLanguage();
      if (savedLanguage != null) {
        state = Locale(savedLanguage, '');
        AppLogger.info('Loaded saved locale: $savedLanguage', tag: 'LOCALE');
      }
    } catch (e) {
      AppLogger.error('Failed to load saved locale', tag: 'LOCALE', error: e);
    }
  }

  Future<void> setLocale(SupportedLanguage language) async {
    try {
      state = Locale(language.code, '');
      await StorageService.saveLanguage(language.code);
      AppLogger.info('Locale changed to: ${language.code}', tag: 'LOCALE');
    } catch (e) {
      AppLogger.error('Failed to save locale', tag: 'LOCALE', error: e);
    }
  }

  bool get isRTL => ['ar', 'he', 'fa'].contains(state.languageCode);
}
