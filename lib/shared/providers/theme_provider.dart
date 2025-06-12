import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../resources/themes/app_theme.dart';
import '../../services/storage_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  static const String _themeKey = 'theme_mode';

  Future<void> _loadThemeMode() async {
    final savedTheme = await StorageService.getString(_themeKey);
    if (savedTheme != null) {
      switch (savedTheme) {
        case AppTheme.lightThemeKey:
          state = ThemeMode.light;
          break;
        case AppTheme.darkThemeKey:
          state = ThemeMode.dark;
          break;
        case AppTheme.systemThemeKey:
          state = ThemeMode.system;
          break;
      }
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode;

    String themeKey;
    switch (themeMode) {
      case ThemeMode.light:
        themeKey = AppTheme.lightThemeKey;
        break;
      case ThemeMode.dark:
        themeKey = AppTheme.darkThemeKey;
        break;
      case ThemeMode.system:
        themeKey = AppTheme.systemThemeKey;
        break;
    }

    await StorageService.saveString(_themeKey, themeKey);
  }

  bool get isLightMode => state == ThemeMode.light;
  bool get isDarkMode => state == ThemeMode.dark;
  bool get isSystemMode => state == ThemeMode.system;
}