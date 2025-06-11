import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../resources/constants/supported_locales.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      tooltip: 'language_selector.title'.tr(),
      onSelected: (locale) async {
        await context.setLocale(locale);
      },
      itemBuilder: (context) => SupportedLocales.all.map((locale) {
        final isSelected = locale == context.locale;
        final languageName = SupportedLocales.getLanguageName(locale.languageCode);

        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            children: [
              if (isSelected)
                const Icon(Icons.check, size: 16)
              else
                const SizedBox(width: 16),
              const SizedBox(width: 8),
              Text(languageName),
              const Spacer(),
              Text(
                locale.languageCode.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}