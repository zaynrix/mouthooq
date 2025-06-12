import 'environment.dart';

class AppConfig {
  // Static configuration that doesn't change between environments
  static const String appIdentifier = 'com.yourcompany.adminapp';
  static const String appScheme = 'adminapp';

  // Localization
  static const List<String> supportedLanguages = ['en', 'ar', 'es', 'fr', 'de'];
  static const String defaultLanguage = 'en';

  // UI Configuration
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const int animationDurationMs = 300;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;

  // Cache Keys
  static const String userCacheKey = 'user_data';
  static const String settingsCacheKey = 'app_settings';
  static const String languageCacheKey = 'selected_language';
  static const String themeCacheKey = 'selected_theme';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String isFirstLaunchKey = 'is_first_launch';

  // Get environment-specific values
  static String get apiBaseUrl => EnvironmentConfig.apiBaseUrl;
  static String get appName => EnvironmentConfig.appName;
  static bool get isProduction => EnvironmentConfig.isProduction;
  static bool get enableDebugLogging => EnvironmentConfig.enableDebugLogging;
}