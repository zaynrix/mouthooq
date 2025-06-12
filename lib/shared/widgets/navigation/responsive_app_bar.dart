import 'package:flutter/material.dart';
import 'package:mouthooq/utils/logging/app_logger.dart';
import '../../../app_config/environment.dart';
import '../debug/debug_log_viewer.dart';
import '../common/localization/language_selector.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const ResponsiveAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        // Regular actions
        ...?actions,

        // Language selector
        const LanguageSelector(),

        // Debug menu (only in development)
        if (EnvironmentConfig.isDevelopment)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Debug Menu',
            onSelected: (value) => _handleDebugMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logs',
                child: Row(
                  children: [
                    Icon(Icons.bug_report, size: 20),
                    SizedBox(width: 8),
                    Text('Debug Logs'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_logs',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, size: 20),
                    SizedBox(width: 8),
                    Text('Clear Logs'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'env_info',
                child: Row(
                  children: [
                    Icon(Icons.info, size: 20),
                    SizedBox(width: 8),
                    Text('Environment Info'),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _handleDebugMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'logs':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DebugLogViewer(),
          ),
        );
        break;
      case 'clear_logs':
        AppLogger.clearLogs();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debug logs cleared')),
        );
        break;
      case 'env_info':
        EnvironmentConfig.printConfig();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Environment info printed to console')),
        );
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
