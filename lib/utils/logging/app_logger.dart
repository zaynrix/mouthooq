import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:mouthooq/utils/logging/log_entry.dart';
import '../../app_config/environment.dart';
import 'log_level.dart';

class AppLogger {
  static const String _tag = 'AdminApp';
  static final List<LogEntry> _logs = [];
  static const int _maxLogEntries = 1000;

  // Private constructor
  AppLogger._();

  // Singleton instance
  static final AppLogger _instance = AppLogger._();
  static AppLogger get instance => _instance;

  // Factory constructor
  factory AppLogger() => _instance;

  // Log storage for debugging
  static List<LogEntry> get logs => List.unmodifiable(_logs);

  // Clear logs
  static void clearLogs() {
    _logs.clear();
  }

  // Get logs by level
  static List<LogEntry> getLogsByLevel(LogLevel level) {
    return _logs.where((log) => log.level == level).toList();
  }

  // Main logging method
  static void _log(
      LogLevel level,
      String message, {
        String? tag,
        Object? error,
        StackTrace? stackTrace,
        Map<String, dynamic>? extra,
      }) {
    // Check if logging is enabled for this level
    if (!_shouldLog(level)) return;

    final timestamp = DateTime.now();
    final logTag = tag ?? _tag;
    final logEntry = LogEntry(
      level: level,
      message: message,
      tag: logTag,
      timestamp: timestamp,
      error: error,
      stackTrace: stackTrace,
      extra: extra,
    );

    // Add to internal storage
    _addLogEntry(logEntry);

    // Format and debugPrint the log
    final formattedLog = _formatLog(logEntry);

    if (kDebugMode) {
      // Use dart:developer log for better formatting in debug tools
      developer.log(
        formattedLog,
        time: timestamp,
        level: level.priority,
        name: logTag,
        error: error,
        stackTrace: stackTrace,
      );
    }

    // debugPrint to console for visibility
    if (EnvironmentConfig.enableDebugLogging) {
      debugPrint(formattedLog);
    }

    // Send to crash reporting in production
    if (level.priority >= LogLevel.error.priority &&
        EnvironmentConfig.enableCrashlytics) {
      _sendToCrashlytics(logEntry);
    }
  }

  // Check if we should log based on environment and level
  static bool _shouldLog(LogLevel level) {
    if (EnvironmentConfig.isProduction) {
      // In production, only log warnings and above
      return level.priority >= LogLevel.warning.priority;
    } else if (EnvironmentConfig.isStaging) {
      // In staging, log info and above
      return level.priority >= LogLevel.info.priority;
    } else {
      // In development, log everything if verbose is enabled, otherwise debug and above
      if (EnvironmentConfig.enableVerboseLogging) {
        return true;
      }
      return level.priority >= LogLevel.debug.priority;
    }
  }

  // Add log entry to internal storage
  static void _addLogEntry(LogEntry entry) {
    _logs.add(entry);

    // Keep only the last N entries
    if (_logs.length > _maxLogEntries) {
      _logs.removeAt(0);
    }
  }

  // Format log message
  static String _formatLog(LogEntry entry) {
    final timestamp = _formatTimestamp(entry.timestamp);
    final level = entry.level.emoji;
    final tag = entry.tag;
    final message = entry.message;

    String formatted = '[$timestamp] $level [$tag] $message';

    if (entry.extra != null && entry.extra!.isNotEmpty) {
      formatted += '\n  Extra: ${entry.extra}';
    }

    if (entry.error != null) {
      formatted += '\n  Error: ${entry.error}';
    }

    return formatted;
  }

  // Format timestamp
  static String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}.'
        '${timestamp.millisecond.toString().padLeft(3, '0')}';
  }

  // Send to crashlytics (placeholder)
  static void _sendToCrashlytics(LogEntry entry) {
    // Implement crashlytics integration here
    // Example: FirebaseCrashlytics.instance.recordError(...)
  }

  // Public logging methods
  static void verbose(
      String message, {
        String? tag,
        Map<String, dynamic>? extra,
      }) {
    _log(LogLevel.verbose, message, tag: tag, extra: extra);
  }

  static void debug(
      String message, {
        String? tag,
        Map<String, dynamic>? extra,
      }) {
    _log(LogLevel.debug, message, tag: tag, extra: extra);
  }

  static void info(
      String message, {
        String? tag,
        Map<String, dynamic>? extra,
      }) {
    _log(LogLevel.info, message, tag: tag, extra: extra);
  }

  static void warning(
      String message, {
        String? tag,
        Object? error,
        Map<String, dynamic>? extra,
      }) {
    _log(LogLevel.warning, message, tag: tag, error: error, extra: extra);
  }

  static void error(
      String message, {
        String? tag,
        Object? error,
        StackTrace? stackTrace,
        Map<String, dynamic>? extra,
      }) {
    _log(LogLevel.error, message,
        tag: tag, error: error, stackTrace: stackTrace, extra: extra);
  }

  static void critical(
      String message, {
        String? tag,
        Object? error,
        StackTrace? stackTrace,
        Map<String, dynamic>? extra,
      }) {
    _log(LogLevel.critical, message,
        tag: tag, error: error, stackTrace: stackTrace, extra: extra);
  }

  // Utility methods for common scenarios
  static void logApiRequest(String method, String url, {Map<String, dynamic>? data}) {
    debug('API Request: $method $url',
        tag: 'API',
        extra: {'method': method, 'url': url, 'data': data});
  }

  static void logApiResponse(String url, int statusCode, {dynamic response}) {
    if (statusCode >= 200 && statusCode < 300) {
      debug('API Response: $statusCode $url',
          tag: 'API',
          extra: {'statusCode': statusCode, 'url': url});
    } else {
      error('API Error: $statusCode $url',
          tag: 'API',
          extra: {'statusCode': statusCode, 'url': url, 'response': response});
    }
  }

  static void logUserAction(String action, {Map<String, dynamic>? context}) {
    info('User Action: $action',
        tag: 'USER',
        extra: context);
  }

  static void logNavigation(String from, String to) {
    debug('Navigation: $from → $to',
        tag: 'NAV');
  }

  static void logAuth(String action, {String? userId, Map<String, dynamic>? extra}) {
    info('Auth: $action',
        tag: 'AUTH',
        extra: {'userId': userId, ...?extra});
  }

  static void logFirebase(String action, {Map<String, dynamic>? extra}) {
    debug('Firebase: $action',
        tag: 'FIREBASE',
        extra: extra);
  }

  static void logValidation(String field, String error) {
    debug('Validation Error: $field - $error',
        tag: 'VALIDATION');
  }

  static void logPerformance(String operation, Duration duration) {
    if (duration.inMilliseconds > 1000) {
      warning('Slow Operation: $operation took ${duration.inMilliseconds}ms',
          tag: 'PERFORMANCE');
    } else {
      debug('Performance: $operation took ${duration.inMilliseconds}ms',
          tag: 'PERFORMANCE');
    }
  }
}
