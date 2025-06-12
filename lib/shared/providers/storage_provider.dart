import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/storage_service.dart';
import '../../utils/logging/app_logger.dart';

// Since StorageService uses static methods, we don't need a provider for the service itself
// Instead, create providers for specific storage operations

// Provider for storage info (useful for debug screens)
final storageInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  try {
    return await StorageService.getStorageInfo();
  } catch (e) {
    AppLogger.error('Failed to get storage info', tag: 'STORAGE_PROVIDER', error: e);
    return <String, dynamic>{};
  }
});

// Provider for checking if it's first launch
final isFirstLaunchProvider = FutureProvider<bool>((ref) async {
  try {
    return await StorageService.isFirstLaunch();
  } catch (e) {
    AppLogger.error('Failed to check first launch', tag: 'STORAGE_PROVIDER', error: e);
    return true; // Default to first launch if error
  }
});

// Provider for remember login status
final rememberLoginProvider = FutureProvider<bool>((ref) async {
  try {
    return await StorageService.getRememberLogin();
  } catch (e) {
    AppLogger.error('Failed to get remember login', tag: 'STORAGE_PROVIDER', error: e);
    return false; // Default to false if error
  }
});

// Provider for user ID (useful for checking if user is logged in)
final userIdProvider = FutureProvider<String?>((ref) async {
  try {
    return await StorageService.getUserId();
  } catch (e) {
    AppLogger.error('Failed to get user ID', tag: 'STORAGE_PROVIDER', error: e);
    return null;
  }
});

// Provider for checking if access token exists
final hasAccessTokenProvider = FutureProvider<bool>((ref) async {
  try {
    final token = await StorageService.getAccessToken();
    return token != null && token.isNotEmpty;
  } catch (e) {
    AppLogger.error('Failed to check access token', tag: 'STORAGE_PROVIDER', error: e);
    return false;
  }
});

// State provider for storage operations (for methods that modify state)
final storageOperationsProvider = StateNotifierProvider<StorageOperationsNotifier, AsyncValue<void>>((ref) {
  return StorageOperationsNotifier();
});

class StorageOperationsNotifier extends StateNotifier<AsyncValue<void>> {
  StorageOperationsNotifier() : super(const AsyncValue.data(null));

  Future<void> clearAllStorage() async {
    state = const AsyncValue.loading();
    try {
      await StorageService.clearAll();
      state = const AsyncValue.data(null);
      AppLogger.info('All storage cleared successfully', tag: 'STORAGE_OPERATIONS');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      AppLogger.error('Failed to clear all storage', tag: 'STORAGE_OPERATIONS', error: e);
    }
  }

  Future<void> clearCache() async {
    state = const AsyncValue.loading();
    try {
      await StorageService.clearCache();
      state = const AsyncValue.data(null);
      AppLogger.info('Cache cleared successfully', tag: 'STORAGE_OPERATIONS');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      AppLogger.error('Failed to clear cache', tag: 'STORAGE_OPERATIONS', error: e);
    }
  }

  Future<void> clearUserData() async {
    state = const AsyncValue.loading();
    try {
      await StorageService.clearUserData();
      state = const AsyncValue.data(null);
      AppLogger.info('User data cleared successfully', tag: 'STORAGE_OPERATIONS');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      AppLogger.error('Failed to clear user data', tag: 'STORAGE_OPERATIONS', error: e);
    }
  }

  Future<void> clearTokens() async {
    state = const AsyncValue.loading();
    try {
      await StorageService.clearTokens();
      state = const AsyncValue.data(null);
      AppLogger.info('Tokens cleared successfully', tag: 'STORAGE_OPERATIONS');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      AppLogger.error('Failed to clear tokens', tag: 'STORAGE_OPERATIONS', error: e);
    }
  }

  Future<Map<String, dynamic>> exportSettings() async {
    try {
      final settings = await StorageService.exportSettings();
      AppLogger.info('Settings exported successfully', tag: 'STORAGE_OPERATIONS');
      return settings;
    } catch (e) {
      AppLogger.error('Failed to export settings', tag: 'STORAGE_OPERATIONS', error: e);
      return <String, dynamic>{};
    }
  }

  Future<void> importSettings(Map<String, dynamic> settings) async {
    state = const AsyncValue.loading();
    try {
      await StorageService.importSettings(settings);
      state = const AsyncValue.data(null);
      AppLogger.info('Settings imported successfully', tag: 'STORAGE_OPERATIONS');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      AppLogger.error('Failed to import settings', tag: 'STORAGE_OPERATIONS', error: e);
    }
  }
}