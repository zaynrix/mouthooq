import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../app_config/environment.dart';
import '../utils/logging/app_logger.dart';

enum StorageType {
  preferences,  // SharedPreferences - for simple key-value pairs
  secure,      // FlutterSecureStorage - for sensitive data (tokens, passwords)
  cache,       // Hive - for complex objects and caching
}

class StorageService {
  // Private constructor
  StorageService._();

  // Singleton instances
  static SharedPreferences? _preferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    wOptions: WindowsOptions(),
    lOptions: LinuxOptions(),
    webOptions: WebOptions(
      dbName: 'AdminAppSecure',
      publicKey: 'AdminAppPublicKey',
    ),
  );

  // Hive boxes
  static Box? _cacheBox;
  static Box? _userBox;
  static Box? _settingsBox;

  // Initialize storage services
  static Future<void> initialize() async {
    try {
      AppLogger.info('Initializing storage services', tag: 'STORAGE');

      // Initialize SharedPreferences
      _preferences = await SharedPreferences.getInstance();
      AppLogger.debug('SharedPreferences initialized', tag: 'STORAGE');

      // Initialize Hive
      await Hive.initFlutter('AdminAppCache');

      // Open Hive boxes
      _cacheBox = await Hive.openBox('cache');
      _userBox = await Hive.openBox('user_data');
      _settingsBox = await Hive.openBox('app_settings');

      AppLogger.debug('Hive boxes initialized', tag: 'STORAGE');

      // Print storage info in debug mode
      if (EnvironmentConfig.enableDebugLogging) {
        await _printStorageInfo();
      }

      AppLogger.info('Storage services initialized successfully', tag: 'STORAGE');

    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize storage services',
          tag: 'STORAGE',
          error: e,
          stackTrace: stackTrace);
      rethrow;
    }
  }

  // Clear all storage (useful for logout or reset)
  static Future<void> clearAll() async {
    try {
      AppLogger.info('Clearing all storage', tag: 'STORAGE');

      // Clear SharedPreferences (keep language and theme)
      final keysToKeep = {
        'selected_language',
        'theme_mode',
        'is_first_launch',
      };

      final prefs = await _getPreferences();
      final allKeys = prefs.getKeys();

      for (final key in allKeys) {
        if (!keysToKeep.contains(key)) {
          await prefs.remove(key);
        }
      }

      // Clear secure storage
      await _secureStorage.deleteAll();

      // Clear Hive boxes
      await _cacheBox?.clear();
      await _userBox?.clear();
      // Don't clear settings box (keep user preferences)

      AppLogger.info('All storage cleared successfully', tag: 'STORAGE');

    } catch (e, stackTrace) {
      AppLogger.error('Failed to clear storage',
          tag: 'STORAGE',
          error: e,
          stackTrace: stackTrace);
    }
  }

  // === SHARED PREFERENCES METHODS ===

  static Future<SharedPreferences> _getPreferences() async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  // String operations
  static Future<bool> saveString(String key, String value) async {
    try {
      final prefs = await _getPreferences();
      final result = await prefs.setString(key, value);
      AppLogger.debug('Saved string: $key', tag: 'STORAGE');
      return result;
    } catch (e) {
      AppLogger.error('Failed to save string: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  static Future<String?> getString(String key, {String? defaultValue}) async {
    try {
      final prefs = await _getPreferences();
      final value = prefs.getString(key) ?? defaultValue;
      AppLogger.debug('Retrieved string: $key = $value', tag: 'STORAGE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get string: $key', tag: 'STORAGE', error: e);
      return defaultValue;
    }
  }

  // Boolean operations
  static Future<bool> saveBool(String key, bool value) async {
    try {
      final prefs = await _getPreferences();
      final result = await prefs.setBool(key, value);
      AppLogger.debug('Saved bool: $key = $value', tag: 'STORAGE');
      return result;
    } catch (e) {
      AppLogger.error('Failed to save bool: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      final prefs = await _getPreferences();
      final value = prefs.getBool(key) ?? defaultValue;
      AppLogger.debug('Retrieved bool: $key = $value', tag: 'STORAGE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get bool: $key', tag: 'STORAGE', error: e);
      return defaultValue;
    }
  }

  // Integer operations
  static Future<bool> saveInt(String key, int value) async {
    try {
      final prefs = await _getPreferences();
      final result = await prefs.setInt(key, value);
      AppLogger.debug('Saved int: $key = $value', tag: 'STORAGE');
      return result;
    } catch (e) {
      AppLogger.error('Failed to save int: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    try {
      final prefs = await _getPreferences();
      final value = prefs.getInt(key) ?? defaultValue;
      AppLogger.debug('Retrieved int: $key = $value', tag: 'STORAGE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get int: $key', tag: 'STORAGE', error: e);
      return defaultValue;
    }
  }

  // Double operations
  static Future<bool> saveDouble(String key, double value) async {
    try {
      final prefs = await _getPreferences();
      final result = await prefs.setDouble(key, value);
      AppLogger.debug('Saved double: $key = $value', tag: 'STORAGE');
      return result;
    } catch (e) {
      AppLogger.error('Failed to save double: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  static Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    try {
      final prefs = await _getPreferences();
      final value = prefs.getDouble(key) ?? defaultValue;
      AppLogger.debug('Retrieved double: $key = $value', tag: 'STORAGE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get double: $key', tag: 'STORAGE', error: e);
      return defaultValue;
    }
  }

  // List<String> operations
  static Future<bool> saveStringList(String key, List<String> value) async {
    try {
      final prefs = await _getPreferences();
      final result = await prefs.setStringList(key, value);
      AppLogger.debug('Saved string list: $key (${value.length} items)', tag: 'STORAGE');
      return result;
    } catch (e) {
      AppLogger.error('Failed to save string list: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  static Future<List<String>> getStringList(String key, {List<String>? defaultValue}) async {
    try {
      final prefs = await _getPreferences();
      final value = prefs.getStringList(key) ?? defaultValue ?? [];
      AppLogger.debug('Retrieved string list: $key (${value.length} items)', tag: 'STORAGE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get string list: $key', tag: 'STORAGE', error: e);
      return defaultValue ?? [];
    }
  }

  // Remove key
  static Future<bool> remove(String key) async {
    try {
      final prefs = await _getPreferences();
      final result = await prefs.remove(key);
      AppLogger.debug('Removed key: $key', tag: 'STORAGE');
      return result;
    } catch (e) {
      AppLogger.error('Failed to remove key: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  // Check if key exists
  static Future<bool> containsKey(String key) async {
    try {
      final prefs = await _getPreferences();
      return prefs.containsKey(key);
    } catch (e) {
      AppLogger.error('Failed to check key: $key', tag: 'STORAGE', error: e);
      return false;
    }
  }

  // === SECURE STORAGE METHODS ===

  static Future<void> saveSecure(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      AppLogger.debug('Saved secure data: $key', tag: 'SECURE_STORAGE');
    } catch (e) {
      AppLogger.error('Failed to save secure data: $key', tag: 'SECURE_STORAGE', error: e);
      rethrow;
    }
  }

  static Future<String?> getSecure(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      AppLogger.debug('Retrieved secure data: $key ${value != null ? '(found)' : '(not found)'}',
          tag: 'SECURE_STORAGE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get secure data: $key', tag: 'SECURE_STORAGE', error: e);
      return null;
    }
  }

  static Future<void> removeSecure(String key) async {
    try {
      await _secureStorage.delete(key: key);
      AppLogger.debug('Removed secure data: $key', tag: 'SECURE_STORAGE');
    } catch (e) {
      AppLogger.error('Failed to remove secure data: $key', tag: 'SECURE_STORAGE', error: e);
    }
  }

  static Future<bool> containsSecureKey(String key) async {
    try {
      return await _secureStorage.containsKey(key: key);
    } catch (e) {
      AppLogger.error('Failed to check secure key: $key', tag: 'SECURE_STORAGE', error: e);
      return false;
    }
  }

  static Future<void> clearSecure() async {
    try {
      await _secureStorage.deleteAll();
      AppLogger.debug('Cleared all secure data', tag: 'SECURE_STORAGE');
    } catch (e) {
      AppLogger.error('Failed to clear secure data', tag: 'SECURE_STORAGE', error: e);
    }
  }

  // === HIVE CACHE METHODS ===

  static Future<void> saveToCache(String key, dynamic value) async {
    try {
      await _cacheBox?.put(key, value);
      AppLogger.debug('Saved to cache: $key', tag: 'CACHE');
    } catch (e) {
      AppLogger.error('Failed to save to cache: $key', tag: 'CACHE', error: e);
    }
  }

  static T? getFromCache<T>(String key, {T? defaultValue}) {
    try {
      final value = _cacheBox?.get(key, defaultValue: defaultValue) as T?;
      AppLogger.debug('Retrieved from cache: $key ${value != null ? '(found)' : '(not found)'}',
          tag: 'CACHE');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get from cache: $key', tag: 'CACHE', error: e);
      return defaultValue;
    }
  }

  static Future<void> removeFromCache(String key) async {
    try {
      await _cacheBox?.delete(key);
      AppLogger.debug('Removed from cache: $key', tag: 'CACHE');
    } catch (e) {
      AppLogger.error('Failed to remove from cache: $key', tag: 'CACHE', error: e);
    }
  }

  static bool containsCacheKey(String key) {
    try {
      return _cacheBox?.containsKey(key) ?? false;
    } catch (e) {
      AppLogger.error('Failed to check cache key: $key', tag: 'CACHE', error: e);
      return false;
    }
  }

  static Future<void> clearCache() async {
    try {
      await _cacheBox?.clear();
      AppLogger.debug('Cleared cache', tag: 'CACHE');
    } catch (e) {
      AppLogger.error('Failed to clear cache', tag: 'CACHE', error: e);
    }
  }

  // Cache with expiration
  static Future<void> saveToCacheWithExpiry(String key, dynamic value, Duration expiry) async {
    try {
      final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;
      final cacheData = {
        'value': value,
        'expiry': expiryTime,
      };
      await _cacheBox?.put(key, cacheData);
      AppLogger.debug('Saved to cache with expiry: $key (expires in ${expiry.inMinutes}min)', tag: 'CACHE');
    } catch (e) {
      AppLogger.error('Failed to save to cache with expiry: $key', tag: 'CACHE', error: e);
    }
  }

  static T? getFromCacheWithExpiry<T>(String key, {T? defaultValue}) {
    try {
      final cacheData = _cacheBox?.get(key) as Map<dynamic, dynamic>?;

      if (cacheData == null) return defaultValue;

      final expiryTime = cacheData['expiry'] as int?;
      final now = DateTime.now().millisecondsSinceEpoch;

      if (expiryTime != null && now > expiryTime) {
        // Cache expired, remove it
        _cacheBox?.delete(key);
        AppLogger.debug('Cache expired and removed: $key', tag: 'CACHE');
        return defaultValue;
      }

      final value = cacheData['value'] as T?;
      AppLogger.debug('Retrieved from cache (not expired): $key', tag: 'CACHE');
      return value;

    } catch (e) {
      AppLogger.error('Failed to get from cache with expiry: $key', tag: 'CACHE', error: e);
      return defaultValue;
    }
  }

  // === USER DATA METHODS ===

  static Future<void> saveUserData(String key, dynamic value) async {
    try {
      await _userBox?.put(key, value);
      AppLogger.debug('Saved user data: $key', tag: 'USER_DATA');
    } catch (e) {
      AppLogger.error('Failed to save user data: $key', tag: 'USER_DATA', error: e);
    }
  }

  static T? getUserData<T>(String key, {T? defaultValue}) {
    try {
      final value = _userBox?.get(key, defaultValue: defaultValue) as T?;
      AppLogger.debug('Retrieved user data: $key ${value != null ? '(found)' : '(not found)'}',
          tag: 'USER_DATA');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get user data: $key', tag: 'USER_DATA', error: e);
      return defaultValue;
    }
  }

  static Future<void> removeUserData(String key) async {
    try {
      await _userBox?.delete(key);
      AppLogger.debug('Removed user data: $key', tag: 'USER_DATA');
    } catch (e) {
      AppLogger.error('Failed to remove user data: $key', tag: 'USER_DATA', error: e);
    }
  }

  static Future<void> clearUserData() async {
    try {
      await _userBox?.clear();
      AppLogger.debug('Cleared user data', tag: 'USER_DATA');
    } catch (e) {
      AppLogger.error('Failed to clear user data', tag: 'USER_DATA', error: e);
    }
  }

  // === SETTINGS METHODS ===

  static Future<void> saveSetting(String key, dynamic value) async {
    try {
      await _settingsBox?.put(key, value);
      AppLogger.debug('Saved setting: $key', tag: 'SETTINGS');
    } catch (e) {
      AppLogger.error('Failed to save setting: $key', tag: 'SETTINGS', error: e);
    }
  }

  static T? getSetting<T>(String key, {T? defaultValue}) {
    try {
      final value = _settingsBox?.get(key, defaultValue: defaultValue) as T?;
      AppLogger.debug('Retrieved setting: $key ${value != null ? '(found)' : '(not found)'}',
          tag: 'SETTINGS');
      return value;
    } catch (e) {
      AppLogger.error('Failed to get setting: $key', tag: 'SETTINGS', error: e);
      return defaultValue;
    }
  }

  // === CONVENIENCE METHODS FOR APP-SPECIFIC DATA ===

  // Authentication tokens
  static Future<void> saveAccessToken(String token) async {
    await saveSecure('access_token', token);
  }

  static Future<String?> getAccessToken() async {
    return await getSecure('access_token');
  }

  static Future<void> saveRefreshToken(String token) async {
    await saveSecure('refresh_token', token);
  }

  static Future<String?> getRefreshToken() async {
    return await getSecure('refresh_token');
  }

  static Future<void> clearTokens() async {
    await removeSecure('access_token');
    await removeSecure('refresh_token');
  }

  // User preferences
  static Future<void> saveLanguage(String languageCode) async {
    await saveString('selected_language', languageCode);
  }

  static Future<String?> getLanguage() async {
    return await getString('selected_language');
  }

  static Future<void> saveTheme(String themeMode) async {
    await saveString('theme_mode', themeMode);
  }

  static Future<String?> getTheme() async {
    return await getString('theme_mode');
  }

  // First launch
  static Future<void> setFirstLaunch(bool isFirst) async {
    await saveBool('is_first_launch', isFirst);
  }

  static Future<bool> isFirstLaunch() async {
    return await getBool('is_first_launch', defaultValue: true);
  }

  // User ID
  static Future<void> saveUserId(String userId) async {
    await saveSecure('user_id', userId);
  }

  static Future<String?> getUserId() async {
    return await getSecure('user_id');
  }

  // Remember login
  static Future<void> setRememberLogin(bool remember) async {
    await saveBool('remember_login', remember);
  }

  static Future<bool> getRememberLogin() async {
    return await getBool('remember_login', defaultValue: false);
  }

  // === UTILITY METHODS ===

  static Future<void> _printStorageInfo() async {
    if (!EnvironmentConfig.enableDebugLogging) return;

    try {
      final prefs = await _getPreferences();
      final prefsKeys = prefs.getKeys();
      final cacheKeys = _cacheBox?.keys ?? [];
      final userKeys = _userBox?.keys ?? [];
      final settingsKeys = _settingsBox?.keys ?? [];

      print('=== STORAGE INFO ===');
      print('SharedPreferences keys: ${prefsKeys.length}');
      print('Cache keys: ${cacheKeys.length}');
      print('User data keys: ${userKeys.length}');
      print('Settings keys: ${settingsKeys.length}');
      print('==================');

    } catch (e) {
      AppLogger.error('Failed to print storage info', tag: 'STORAGE', error: e);
    }
  }

  // Get storage size information
  static Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final prefs = await _getPreferences();

      return {
        'preferences_keys': prefs.getKeys().length,
        'cache_keys': _cacheBox?.keys.length ?? 0,
        'user_data_keys': _userBox?.keys.length ?? 0,
        'settings_keys': _settingsBox?.keys.length ?? 0,
        'cache_size_mb': _cacheBox?.length ?? 0,
        'platform': defaultTargetPlatform.name,
      };
    } catch (e) {
      AppLogger.error('Failed to get storage info', tag: 'STORAGE', error: e);
      return {};
    }
  }

  // Export settings (for backup)
  static Future<Map<String, dynamic>> exportSettings() async {
    try {
      final prefs = await _getPreferences();
      final settings = <String, dynamic>{};

      // Export only non-sensitive settings
      final keysToExport = {
        'selected_language',
        'theme_mode',
        'is_first_launch',
        'remember_login',
      };

      for (final key in keysToExport) {
        if (prefs.containsKey(key)) {
          final value = prefs.get(key);
          settings[key] = value;
        }
      }

      // Add settings from settings box
      final settingsBox = _settingsBox;
      if (settingsBox != null) {
        for (final key in settingsBox.keys) {
          settings['setting_$key'] = settingsBox.get(key);
        }
      }

      AppLogger.info('Exported ${settings.length} settings', tag: 'STORAGE');
      return settings;

    } catch (e) {
      AppLogger.error('Failed to export settings', tag: 'STORAGE', error: e);
      return {};
    }
  }

  // Import settings (for restore)
  static Future<void> importSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await _getPreferences();

      for (final entry in settings.entries) {
        if (entry.key.startsWith('setting_')) {
          // Settings box data
          final key = entry.key.substring(8); // Remove 'setting_' prefix
          await _settingsBox?.put(key, entry.value);
        } else {
          // SharedPreferences data
          final value = entry.value;
          if (value is String) {
            await prefs.setString(entry.key, value);
          } else if (value is bool) {
            await prefs.setBool(entry.key, value);
          } else if (value is int) {
            await prefs.setInt(entry.key, value);
          } else if (value is double) {
            await prefs.setDouble(entry.key, value);
          } else if (value is List<String>) {
            await prefs.setStringList(entry.key, value);
          }
        }
      }

      AppLogger.info('Imported ${settings.length} settings', tag: 'STORAGE');

    } catch (e) {
      AppLogger.error('Failed to import settings', tag: 'STORAGE', error: e);
    }
  }
}
