class StorageKeys {
  // Private constructor
  StorageKeys._();

  // Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String rememberLogin = 'remember_login';

  // User Preferences
  static const String selectedLanguage = 'selected_language';
  static const String themeMode = 'theme_mode';
  static const String isFirstLaunch = 'is_first_launch';

  // App Settings
  static const String notificationsEnabled = 'notifications_enabled';
  static const String analyticsEnabled = 'analytics_enabled';
  static const String autoSyncEnabled = 'auto_sync_enabled';

  // Cache Keys
  static const String userProfile = 'user_profile';
  static const String usersList = 'users_list';
  static const String customFields = 'custom_fields';
  static const String appConfig = 'app_config';

  // User Data Keys
  static const String recentSearches = 'recent_searches';
  static const String favoriteUsers = 'favorite_users';
  static const String lastSyncTime = 'last_sync_time';

  // Debug Keys
  static const String debugLogsEnabled = 'debug_logs_enabled';
  static const String performanceLogsEnabled = 'performance_logs_enabled';
}