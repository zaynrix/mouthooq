import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mouthooq/resources/themes/app_colors.dart';
import 'package:mouthooq/resources/themes/localized_themes.dart';
import '../../app_config/environment.dart';
import '../../resources/constants/supported_locales.dart';
import 'text_styles.dart';
import 'dimensions.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Theme mode constants
  static const String lightThemeKey = 'light_theme';
  static const String darkThemeKey = 'dark_theme';
  static const String systemThemeKey = 'system_theme';

  // Get theme based on locale
  static ThemeData getLightTheme(Locale locale) {
    final baseTheme = _baseLightTheme;

    if (SupportedLocales.isRTL(locale.languageCode)) {
      return RTLTheme.getRTLTheme(baseTheme);
    }

    return baseTheme;
  }

  static ThemeData getDarkTheme(Locale locale) {
    final baseTheme = _baseDarkTheme;

    if (SupportedLocales.isRTL(locale.languageCode)) {
      return RTLTheme.getRTLTheme(baseTheme);
    }

    return baseTheme;
  }

  // Base Light Theme
  static ThemeData get _baseLightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      background: AppColors.lightBackground,
      error: AppColors.error,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: AppColors.lightBackground,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: AppDimensions.elevation,
      centerTitle: false,
      titleTextStyle: AppTextStyles.appBarTitle,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.lightSurface,
      elevation: AppDimensions.cardElevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingMedium,
      ),
      filled: false,
      labelStyle: AppTextStyles.inputLabel,
      hintStyle: AppTextStyles.inputHint,
      errorStyle: AppTextStyles.inputError,
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.disabled,
        disabledForegroundColor: AppColors.onDisabled,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondary,
      foregroundColor: Colors.white,
      elevation: AppDimensions.fabElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.fabRadius),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: AppDimensions.elevation,
      selectedLabelStyle: AppTextStyles.navLabel,
      unselectedLabelStyle: AppTextStyles.navLabel,
    ),

    // Navigation Rail Theme
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedIconTheme: IconThemeData(color: AppColors.primary),
      unselectedIconTheme: IconThemeData(color: AppColors.onSurfaceVariant),
      selectedLabelTextStyle: AppTextStyles.navLabel.copyWith(color: AppColors.primary),
      unselectedLabelTextStyle: AppTextStyles.navLabel.copyWith(color: AppColors.onSurfaceVariant),
    ),

    // Drawer Theme
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.lightSurface,
      elevation: AppDimensions.elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.borderRadius),
          bottomRight: Radius.circular(AppDimensions.borderRadius),
        ),
      ),
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightChipBackground,
      selectedColor: AppColors.primary,
      disabledColor: AppColors.disabled,
      labelStyle: AppTextStyles.chipLabel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingXSmall,
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.lightSurface,
      elevation: AppDimensions.dialogElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
      ),
      titleTextStyle: AppTextStyles.dialogTitle,
      contentTextStyle: AppTextStyles.dialogContent,
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceVariant,
      contentTextStyle: AppTextStyles.snackBarContent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.lightBorder,
      circularTrackColor: AppColors.lightBorder,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColors.lightBorder,
      thickness: 1,
      space: AppDimensions.paddingMedium,
    ),

    // Font and Text Theme
    fontFamily: _getFontFamily(),
    textTheme: _getTextTheme(Brightness.light),
  );

  // Base Dark Theme
  static ThemeData get _baseDarkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
      error: AppColors.errorDark,
      brightness: Brightness.dark,
      onSurface: AppColors.onDarkSurface,
      onBackground: AppColors.onDarkBackground,
    ),

    scaffoldBackgroundColor: AppColors.darkBackground,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.onDarkSurface,
      elevation: AppDimensions.elevation,
      centerTitle: false,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(
        color: AppColors.onDarkSurface,
      ),
      iconTheme: IconThemeData(color: AppColors.onDarkSurface),
      actionsIconTheme: IconThemeData(color: AppColors.onDarkSurface),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.darkSurface,
      elevation: AppDimensions.cardElevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.errorDark, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        borderSide: BorderSide(color: AppColors.errorDark, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingMedium,
      ),
      fillColor: AppColors.darkInputFill,
      filled: true,
      labelStyle: AppTextStyles.inputLabel.copyWith(color: AppColors.onDarkSurface),
      hintStyle: AppTextStyles.inputHint.copyWith(color: AppColors.onDarkSurfaceVariant),
      errorStyle: AppTextStyles.inputError.copyWith(color: AppColors.errorDark),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.disabledDark,
        disabledForegroundColor: AppColors.onDisabledDark,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        side: BorderSide(color: AppColors.primaryDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryDark,
      foregroundColor: AppColors.onSecondary,
      elevation: AppDimensions.fabElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.fabRadius),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.onDarkSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: AppDimensions.elevation,
      selectedLabelStyle: AppTextStyles.navLabel,
      unselectedLabelStyle: AppTextStyles.navLabel,
    ),

    // Navigation Rail Theme
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedIconTheme: IconThemeData(color: AppColors.primaryDark),
      unselectedIconTheme: IconThemeData(color: AppColors.onDarkSurfaceVariant),
      selectedLabelTextStyle: AppTextStyles.navLabel.copyWith(color: AppColors.primaryDark),
      unselectedLabelTextStyle: AppTextStyles.navLabel.copyWith(color: AppColors.onDarkSurfaceVariant),
    ),

    // Drawer Theme
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: AppDimensions.elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.borderRadius),
          bottomRight: Radius.circular(AppDimensions.borderRadius),
        ),
      ),
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      textColor: AppColors.onDarkSurface,
      iconColor: AppColors.onDarkSurface,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkChipBackground,
      selectedColor: AppColors.primaryDark,
      disabledColor: AppColors.disabledDark,
      labelStyle: AppTextStyles.chipLabel.copyWith(color: AppColors.onDarkSurface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingXSmall,
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.darkSurface,
      elevation: AppDimensions.dialogElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
      ),
      titleTextStyle: AppTextStyles.dialogTitle.copyWith(color: AppColors.onDarkSurface),
      contentTextStyle: AppTextStyles.dialogContent.copyWith(color: AppColors.onDarkSurface),
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkSurfaceVariant,
      contentTextStyle: AppTextStyles.snackBarContent.copyWith(color: AppColors.onDarkSurface),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primaryDark,
      linearTrackColor: AppColors.darkBorder,
      circularTrackColor: AppColors.darkBorder,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
      space: AppDimensions.paddingMedium,
    ),

    // Font and Text Theme
    fontFamily: _getFontFamily(),
    textTheme: _getTextTheme(Brightness.dark),
  );

  // Get font family based on environment (for testing different fonts)
  static String _getFontFamily() {
    if (EnvironmentConfig.enableExperimentalUI) {
      // Use different font in experimental mode
      return GoogleFonts.inter().fontFamily ?? 'Inter';
    }
    return GoogleFonts.cairo().fontFamily ?? 'Cairo';
  }

  // Get text theme based on brightness
  static TextTheme _getTextTheme(Brightness brightness) {
    final baseTextTheme = brightness == Brightness.light
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme);

    return baseTextTheme.copyWith(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  // Debug theme info (development only)
  static void printThemeInfo() {
    if (EnvironmentConfig.enableDebugLogging) {
      debugPrint('=== APP THEME INFO ===');
      debugPrint('Primary Color: ${AppColors.primary}');
      debugPrint('Secondary Color: ${AppColors.secondary}');
      debugPrint('Font Family: ${_getFontFamily()}');
      debugPrint('Border Radius: ${AppDimensions.borderRadius}');
      debugPrint('Experimental UI: ${EnvironmentConfig.enableExperimentalUI}');
      debugPrint('====================');
    }
  }
}
