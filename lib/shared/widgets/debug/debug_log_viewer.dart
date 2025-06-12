import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mouthooq/app_config/environment.dart';
import 'package:mouthooq/utils/logging/app_logger.dart';
import 'package:mouthooq/utils/logging/log_entry.dart';
import 'package:mouthooq/utils/logging/log_level.dart';
class DebugLogViewer extends StatefulWidget {
  const DebugLogViewer({super.key});

  @override
  State<DebugLogViewer> createState() => _DebugLogViewerState();
}

class _DebugLogViewerState extends State<DebugLogViewer> {
  LogLevel? _filterLevel;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Only show in debug mode
    if (!EnvironmentConfig.enableDebugLogging) {
      return const SizedBox.shrink();
    }

    final logs = _getFilteredLogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              AppLogger.clearLogs();
              setState(() {});
            },
            tooltip: 'Clear Logs',
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => _copyAllLogs(),
            tooltip: 'Copy All Logs',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search logs...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<LogLevel?>(
                  value: _filterLevel,
                  hint: const Text('Filter Level'),
                  onChanged: (level) {
                    setState(() {
                      _filterLevel = level;
                    });
                  },
                  items: [
                    const DropdownMenuItem<LogLevel?>(
                      value: null,
                      child: Text('All Levels'),
                    ),
                    ...LogLevel.values.map((level) => DropdownMenuItem(
                      value: level,
                      child: Text('${level.emoji} ${level.name}'),
                    )),
                  ],
                ),
              ],
            ),
          ),
          // Log list
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              reverse: true, // Show newest first
              itemBuilder: (context, index) {
                final log = logs[logs.length - 1 - index];
                return _LogTile(log: log);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<LogEntry> _getFilteredLogs() {
    var logs = AppLogger.logs;

    if (_filterLevel != null) {
      logs = logs.where((log) => log.level == _filterLevel).toList();
    }

    if (_searchQuery.isNotEmpty) {
      logs = logs.where((log) =>
      log.message.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          log.tag.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return logs;
  }

  void _copyAllLogs() {
    final logs = _getFilteredLogs();
    final logText = logs.map((log) =>
    '[${log.timestamp}] ${log.level.emoji} [${log.tag}] ${log.message}'
    ).join('\n');

    Clipboard.setData(ClipboardData(text: logText));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logs copied to clipboard')),
    );
  }
}

class _LogTile extends StatelessWidget {
  final LogEntry log;

  const _LogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        leading: Text(log.level.emoji),
        title: Text(
          log.message,
          style: TextStyle(
            color: _getLevelColor(log.level),
            fontWeight: log.level.priority >= LogLevel.error.priority
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          '${log.tag} • ${_formatTime(log.timestamp)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        children: [
          if (log.extra != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Extra Data:', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(log.extra.toString()),
                ],
              ),
            ),
          ],
          if (log.error != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Error:', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(log.error.toString(), style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          if (log.stackTrace != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stack Trace:', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(
                    log.stackTrace.toString(),
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return Colors.grey;
      case LogLevel.debug:
        return Colors.blue;
      case LogLevel.info:
        return Colors.green;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.critical:
        return Colors.red.shade900;
    }
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}';
  }
}