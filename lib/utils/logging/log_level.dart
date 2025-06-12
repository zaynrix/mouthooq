enum LogLevel {
  verbose(0, 'VERBOSE', '🔍'),
  debug(1, 'DEBUG', '🐛'),
  info(2, 'INFO', 'ℹ️'),
  warning(3, 'WARNING', '⚠️'),
  error(4, 'ERROR', '❌'),
  critical(5, 'CRITICAL', '🚨');

  const LogLevel(this.priority, this.name, this.emoji);

  final int priority;
  final String name;
  final String emoji;
}