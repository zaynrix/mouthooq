import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:mouthooq/utils/enums/supported_language.dart';
import 'package:mouthooq/utils/extensions/easy_localization_extensions.dart';
import 'package:mouthooq/utils/localization/language_utils.dart';
import '../../../../resources/constants/supported_locales.dart';
class RTLAwareWidget extends StatelessWidget {
  final Widget child;
  final Widget? rtlChild;

  const RTLAwareWidget({
    super.key,
    required this.child,
    this.rtlChild,
  });

  @override
  Widget build(BuildContext context) {
    final language = SupportedLanguage.fromCode(context.languageCode);

    return Directionality(
      textDirection: language.textDirection,
      child: Padding(
        padding: LanguageUtils.getDirectionalPadding(
          language,
          left: 16,
          right: 8,
        ),
        child: Text(
          'welcome'.tr(),
          textAlign: LanguageUtils.getTextAlign(language),
        ),
      ),
    );
  }
}