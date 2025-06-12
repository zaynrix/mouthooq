import 'package:flutter/cupertino.dart';

enum Environment {
  development,
  staging,
  production,
}

class EnvironmentConfig {
  static Environment _environment = Environment.development;

  static Environment get environment => _environment;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;

  // API Configuration
  static String get apiBaseUrl {
    switch (_environment) {
      case Environment.development:
        return 'https://dev-api.yourapp.com/v1';
      case Environment.staging:
        return 'https://staging-api.yourapp.com/v1';
      case Environment.production:
        return 'https://api.yourapp.com/v1';
    }
  }

  static String get apiKey {
    switch (_environment) {
      case Environment.development:
        return 'dev_api_key_here';
      case Environment.staging:
        return 'staging_api_key_here';
      case Environment.production:
        return 'prod_api_key_here';
    }
  }

  // Firebase Configuration
  static String get firebaseProjectId {
    switch (_environment) {
      case Environment.development:
        return 'your-app-dev';
      case Environment.staging:
        return 'your-app-staging';
      case Environment.production:
        return 'your-app-prod';
    }
  }

  static String get firebaseStorageBucket {
    switch (_environment) {
      case Environment.development:
        return 'your-app-dev.appspot.com';
      case Environment.staging:
        return 'your-app-staging.appspot.com';
      case Environment.production:
        return 'your-app-prod.appspot.com';
    }
  }

  static String get firebaseWebApiKey {
    switch (_environment) {
      case Environment.development:
        return 'dev_firebase_web_api_key';
      case Environment.staging:
        return 'staging_firebase_web_api_key';
      case Environment.production:
        return 'prod_firebase_web_api_key';
    }
  }

  static String get firebaseAppId {
    switch (_environment) {
      case Environment.development:
        return 'dev_firebase_app_id';
      case Environment.staging:
        return 'staging_firebase_app_id';
      case Environment.production:
        return 'prod_firebase_app_id';
    }
  }

  static String get firebaseMessagingSenderId {
    switch (_environment) {
      case Environment.development:
        return 'dev_messaging_sender_id';
      case Environment.staging:
        return 'staging_messaging_sender_id';
      case Environment.production:
        return 'prod_messaging_sender_id';
    }
  }

  // Database Configuration
  static String get databaseUrl {
    switch (_environment) {
      case Environment.development:
        return 'https://your-app-dev-default-rtdb.firebaseio.com';
      case Environment.staging:
        return 'https://your-app-staging-default-rtdb.firebaseio.com';
      case Environment.production:
        return 'https://your-app-prod-default-rtdb.firebaseio.com';
    }
  }

  // Storage Configuration
  static String get imageUploadPath {
    switch (_environment) {
      case Environment.development:
        return 'dev/images';
      case Environment.staging:
        return 'staging/images';
      case Environment.production:
        return 'prod/images';
    }
  }

  static String get documentUploadPath {
    switch (_environment) {
      case Environment.development:
        return 'dev/documents';
      case Environment.staging:
        return 'staging/documents';
      case Environment.production:
        return 'prod/documents';
    }
  }

  // Analytics Configuration
  static bool get enableAnalytics {
    switch (_environment) {
      case Environment.development:
        return false; // Disable in development
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }

  static bool get enableCrashlytics {
    switch (_environment) {
      case Environment.development:
        return false; // Disable in development
      case Environment.staging:
        return true;
      case Environment.production:
        return true;
    }
  }

  // Logging Configuration
  static bool get enableDebugLogging {
    switch (_environment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return true;
      case Environment.production:
        return false; // Disable debug logs in production
    }
  }

  static bool get enableVerboseLogging {
    switch (_environment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return false;
      case Environment.production:
        return false;
    }
  }

  // Security Configuration
  static Duration get jwtTokenExpiration {
    switch (_environment) {
      case Environment.development:
        return const Duration(days: 30); // Longer for development
      case Environment.staging:
        return const Duration(days: 7);
      case Environment.production:
        return const Duration(days: 1); // Shorter for production
    }
  }

  static Duration get sessionTimeout {
    switch (_environment) {
      case Environment.development:
        return const Duration(hours: 24);
      case Environment.staging:
        return const Duration(hours: 12);
      case Environment.production:
        return const Duration(hours: 8);
    }
  }

  // Feature Flags
  static bool get enableBetaFeatures {
    switch (_environment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return true;
      case Environment.production:
        return false;
    }
  }

  static bool get enableExperimentalUI {
    switch (_environment) {
      case Environment.development:
        return true;
      case Environment.staging:
        return false;
      case Environment.production:
        return false;
    }
  }

  // Performance Configuration
  static int get httpTimeoutSeconds {
    switch (_environment) {
      case Environment.development:
        return 60; // Longer timeout for development
      case Environment.staging:
        return 30;
      case Environment.production:
        return 15; // Shorter timeout for production
    }
  }

  static int get maxRetryAttempts {
    switch (_environment) {
      case Environment.development:
        return 5;
      case Environment.staging:
        return 3;
      case Environment.production:
        return 2;
    }
  }

  // Cache Configuration
  static Duration get cacheExpiration {
    switch (_environment) {
      case Environment.development:
        return const Duration(minutes: 5); // Short cache for development
      case Environment.staging:
        return const Duration(hours: 1);
      case Environment.production:
        return const Duration(hours: 6);
    }
  }

  // Third-party Service Keys
  static String get googleMapsApiKey {
    switch (_environment) {
      case Environment.development:
        return 'dev_google_maps_key';
      case Environment.staging:
        return 'staging_google_maps_key';
      case Environment.production:
        return 'prod_google_maps_key';
    }
  }

  static String get oneSignalAppId {
    switch (_environment) {
      case Environment.development:
        return 'dev_onesignal_app_id';
      case Environment.staging:
        return 'staging_onesignal_app_id';
      case Environment.production:
        return 'prod_onesignal_app_id';
    }
  }

  // Payment Configuration
  static String get stripePublishableKey {
    switch (_environment) {
      case Environment.development:
        return 'pk_test_dev_stripe_key';
      case Environment.staging:
        return 'pk_test_staging_stripe_key';
      case Environment.production:
        return 'pk_live_prod_stripe_key';
    }
  }

  // App Specific Configuration
  static String get appName {
    switch (_environment) {
      case Environment.development:
        return 'Admin App (Dev)';
      case Environment.staging:
        return 'Admin App (Staging)';
      case Environment.production:
        return 'Admin User Management';
    }
  }

  static String get appVersion => '1.0.0';

  static String get buildNumber {
    switch (_environment) {
      case Environment.development:
        return '1.0.0-dev';
      case Environment.staging:
        return '1.0.0-staging';
      case Environment.production:
        return '1.0.0';
    }
  }

  // Email Configuration
  static String get supportEmail {
    switch (_environment) {
      case Environment.development:
        return 'dev-support@yourapp.com';
      case Environment.staging:
        return 'staging-support@yourapp.com';
      case Environment.production:
        return 'support@yourapp.com';
    }
  }

  // Admin Configuration
  static List<String> get defaultAdminEmails {
    switch (_environment) {
      case Environment.development:
        return ['dev-admin@yourapp.com', 'test@example.com'];
      case Environment.staging:
        return ['staging-admin@yourapp.com'];
      case Environment.production:
        return ['admin@yourapp.com'];
    }
  }

  static int get maxUsersPerAdmin {
    switch (_environment) {
      case Environment.development:
        return 1000; // Higher limit for testing
      case Environment.staging:
        return 500;
      case Environment.production:
        return 100;
    }
  }

  // Print current configuration (for debugging)
  static void printConfig() {
    if (enableDebugLogging) {
      debugPrint('=== ENVIRONMENT CONFIGURATION ===');
      debugPrint('Environment: ${_environment.name}');
      debugPrint('App Name: $appName');
      debugPrint('API Base URL: $apiBaseUrl');
      debugPrint('Firebase Project: $firebaseProjectId');
      debugPrint('Debug Logging: $enableDebugLogging');
      debugPrint('Analytics: $enableAnalytics');
      debugPrint('Beta Features: $enableBetaFeatures');
      debugPrint('================================');
    }
  }
}