import '../logging/app_logger.dart';

extension LoggerExtensions on Object {
  void logDebug(String message, {Map<String, dynamic>? extra}) {
    AppLogger.debug(message, tag: runtimeType.toString(), extra: extra);
  }

  void logInfo(String message, {Map<String, dynamic>? extra}) {
    AppLogger.info(message, tag: runtimeType.toString(), extra: extra);
  }

  void logWarning(String message, {Object? error, Map<String, dynamic>? extra}) {
    AppLogger.warning(message, tag: runtimeType.toString(), error: error, extra: extra);
  }

  void logError(String message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? extra}) {
    AppLogger.error(message, tag: runtimeType.toString(), error: error, stackTrace: stackTrace, extra: extra);
  }
}