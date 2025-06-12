import 'package:flutter/material.dart';
import '../../../app_config/environment.dart';
import '../../../utils/logging/app_logger.dart';
import 'debug_log_viewer.dart';

class DebugFAB extends StatelessWidget {
  const DebugFAB({super.key});

  @override
  Widget build(BuildContext context) {
    // Only show in development
    if (!EnvironmentConfig.isDevelopment) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 80.0, // Above normal FAB
      right: 16.0,
      child: FloatingActionButton.small(
        onPressed: () {
          AppLogger.logUserAction('opened_debug_logs_via_fab');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DebugLogViewer(),
            ),
          );
        },
        backgroundColor: Colors.orange,
        heroTag: 'debug_fab',
        child: const Icon(Icons.bug_report, color: Colors.white),
      ),
    );
  }
}
