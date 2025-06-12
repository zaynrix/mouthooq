import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../shared/providers/theme_provider.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return PopupMenuButton<ThemeMode>(
      icon: Icon(_getThemeIcon(themeMode)),
      tooltip: 'theme_selector.title'.tr(),
      onSelected: (selectedTheme) async {
        await ref.read(themeProvider.notifier).setThemeMode(selectedTheme);
      },
      itemBuilder: (context) => [
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(
                Icons.light_mode,
                color: themeMode == ThemeMode.light ? Theme.of(context).primaryColor : null,
              ),
              const SizedBox(width: 8),
              Text('theme.light'.tr()),
              if (themeMode == ThemeMode.light) ...[
                const Spacer(),
                Icon(Icons.check, color: Theme.of(context).primaryColor, size: 16),
              ],
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(
                Icons.dark_mode,
                color: themeMode == ThemeMode.dark ? Theme.of(context).primaryColor : null,
              ),
              const SizedBox(width: 8),
              Text('theme.dark'.tr()),
              if (themeMode == ThemeMode.dark) ...[
                const Spacer(),
                Icon(Icons.check, color: Theme.of(context).primaryColor, size: 16),
              ],
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(
                Icons.settings_suggest,
                color: themeMode == ThemeMode.system ? Theme.of(context).primaryColor : null,
              ),
              const SizedBox(width: 8),
              Text('theme.system'.tr()),
              if (themeMode == ThemeMode.system) ...[
                const Spacer(),
                Icon(Icons.check, color: Theme.of(context).primaryColor, size: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_suggest;
    }
  }
}