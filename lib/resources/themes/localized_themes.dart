import 'package:flutter/material.dart';
import 'package:mouthooq/resources/themes/dimensions.dart';
import 'package:mouthooq/resources/themes/text_styles.dart';

class RTLTheme {
  static ThemeData getRTLTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
      // AppBar adjustments for RTL
      appBarTheme: baseTheme.appBarTheme.copyWith(
        centerTitle: true, // Center title looks better in RTL
        titleTextStyle: AppTextStyles.appBarTitle.copyWith(
          fontWeight: FontWeight.w600, // Slightly bolder for Arabic
        ),
      ),

      // Text theme adjustments for RTL languages (Arabic)
      textTheme: baseTheme.textTheme.copyWith(
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          height: 1.6, // Better line height for Arabic text
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          height: 1.6,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          height: 1.5,
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          fontWeight: FontWeight.w600, // Arabic looks better with more weight
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      // Drawer theme for RTL
      drawerTheme: DrawerThemeData(
        backgroundColor: baseTheme.scaffoldBackgroundColor,
        elevation: AppDimensions.elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.borderRadius), // Flip for RTL
            bottomLeft: Radius.circular(AppDimensions.borderRadius),
          ),
        ),
      ),

      // List tile theme adjustments
      listTileTheme: baseTheme.listTileTheme.copyWith(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
      ),

      // Input decoration adjustments for RTL
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
      ),
    );
  }
}
