import 'package:flutter/material.dart';
import '../../../app_config/environment.dart';
import '../../../utils/logging/app_logger.dart';
import 'debug_log_viewer.dart';

class DebugOverlay extends StatefulWidget {
  final Widget child;

  const DebugOverlay({super.key, required this.child});

  @override
  State<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends State<DebugOverlay> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Only show in development
    if (!EnvironmentConfig.isDevelopment) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,

        // Debug panel
        Positioned(
          top: MediaQuery.of(context).padding.top + 50,
          right: 16,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isExpanded ? 200 : 50,
              height: _isExpanded ? 150 : 50,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: _isExpanded ? _buildExpandedPanel() : _buildCollapsedPanel(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsedPanel() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = true),
      borderRadius: BorderRadius.circular(12),
      child: const Center(
        child: Icon(Icons.bug_report, color: Colors.orange),
      ),
    );
  }

  Widget _buildExpandedPanel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Debug', style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () => setState(() => _isExpanded = false),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Debug actions
          Expanded(
            child: Column(
              children: [
                _buildDebugButton(
                  'Logs (${AppLogger.logs.length})',
                  Icons.list,
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DebugLogViewer(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 4),

                _buildDebugButton(
                  'Clear',
                  Icons.clear,
                      () {
                    AppLogger.clearLogs();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugButton(String text, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 14),
        label: Text(text, style: const TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.orange.shade200,
        ),
      ),
    );
  }
}