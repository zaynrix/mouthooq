import 'package:mouthooq/utils/logging/app_logger.dart';

class PerformanceLogger {
  static final Map<String, DateTime> _startTimes = {};

  static void start(String operation) {
    _startTimes[operation] = DateTime.now();
    AppLogger.verbose('Performance: Started $operation', tag: 'PERF');
  }

  static void end(String operation) {
    final startTime = _startTimes.remove(operation);
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      AppLogger.logPerformance(operation, duration);
    } else {
      AppLogger.warning('Performance: No start time found for $operation', tag: 'PERF');
    }
  }

  static T measure<T>(String operation, T Function() fn) {
    start(operation);
    try {
      final result = fn();
      end(operation);
      return result;
    } catch (e) {
      end(operation);
      AppLogger.error('Performance: Error in $operation',
          tag: 'PERF',
          error: e);
      rethrow;
    }
  }

  static Future<T> measureAsync<T>(String operation, Future<T> Function() fn) async {
    start(operation);
    try {
      final result = await fn();
      end(operation);
      return result;
    } catch (e) {
      end(operation);
      AppLogger.error('Performance: Error in $operation',
          tag: 'PERF',
          error: e);
      rethrow;
    }
  }
}
