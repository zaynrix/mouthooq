import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
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
    final isRTL = SupportedLocales.isRTL(context.locale.languageCode);

    return Directionality(
      textDirection: isRTL ? m.TextDirection.rtl : m.TextDirection.ltr,
      child: rtlChild != null && isRTL ? rtlChild! : child,
    );
  }
}