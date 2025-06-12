import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/storage_service.dart';
import '../../../app_config/environment.dart';

class StorageInfoWidget extends ConsumerWidget {
  const StorageInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!EnvironmentConfig.isDevelopment) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storage Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            FutureBuilder<Map<String, dynamic>>(
              future: StorageService.getStorageInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final info = snapshot.data ?? {};

                return Column(
                  children: [
                    _buildInfoRow('Platform', info['platform'] ?? 'Unknown'),
                    _buildInfoRow('Preferences Keys', '${info['preferences_keys'] ?? 0}'),
                    _buildInfoRow('Cache Keys', '${info['cache_keys'] ?? 0}'),
                    _buildInfoRow('User Data Keys', '${info['user_data_keys'] ?? 0}'),
                    _buildInfoRow('Settings Keys', '${info['settings_keys'] ?? 0}'),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _exportSettings(context),
                            icon: const Icon(Icons.download),
                            label: const Text('Export Settings'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _clearCache(context),
                            icon: const Icon(Icons.clear),
                            label: const Text('Clear Cache'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _exportSettings(BuildContext context) async {
    try {
      final settings = await StorageService.exportSettings();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exported ${settings.length} settings'),
            action: SnackBarAction(
              label: 'View',
              onPressed: () => _showExportedData(context, settings),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Future<void> _clearCache(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear the cache? This will remove all cached data but keep your settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await StorageService.clearCache();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cache cleared successfully')),
        );
      }
    }
  }

  void _showExportedData(BuildContext context, Map<String, dynamic> settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exported Settings'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: SingleChildScrollView(
            child: Text(
              settings.entries
                  .map((e) => '${e.key}: ${e.value}')
                  .join('\n'),
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}