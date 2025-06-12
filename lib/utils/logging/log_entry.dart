import 'package:mouthooq/utils/logging/log_level.dart';

class LogEntry {
  final LogLevel level;
  final String message;
  final String tag;
  final DateTime timestamp;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? extra;

  const LogEntry({
    required this.level,
    required this.message,
    required this.tag,
    required this.timestamp,
    this.error,
    this.stackTrace,
    this.extra,
  });

  @override
  String toString() {
    return 'LogEntry(level: ${level.name}, message: $message, tag: $tag, timestamp: $timestamp)';
  }
}