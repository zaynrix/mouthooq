import 'package:flutter/material.dart';

class AppColors {
  // Private constructor
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF4CAF50); // Green 600
  static const Color primaryDark = Color(0xFF66BB6A); // Green 400 for dark theme
  static const Color onPrimary = Colors.white;

  // Secondary Colors
  static const Color secondary = Color(0xFF2196F3); // Blue 600
  static const Color secondaryDark = Color(0xFF42A5F5); // Blue 400 for dark theme
  static const Color onSecondary = Colors.white;

  // Surface Colors
  static const Color lightSurface = Colors.white;
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color onLightSurface = Color(0xFF1C1B1F);
  static const Color onDarkSurface = Color(0xFFE6E1E5);

  // Background Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color darkBackground = Color(0xFF121212);
  static const Color onLightBackground = Color(0xFF1C1B1F);
  static const Color onDarkBackground = Color(0xFFE6E1E5);

  // Surface Variant Colors
  static const Color surfaceVariant = Color(0xFFE7E0EC);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  static const Color onDarkSurfaceVariant = Color(0xFFCAC4D0);

  // Border Colors
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color darkBorder = Color(0xFF424242);

  // Error Colors
  static const Color error = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onError = Colors.white;
  static const Color onErrorDark = Color(0xFF000000);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color onSuccess = Colors.white;

  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color onWarning = Colors.white;

  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color onInfo = Colors.white;

  // Disabled Colors
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color disabledDark = Color(0xFF424242);
  static const Color onDisabled = Color(0xFF9E9E9E);
  static const Color onDisabledDark = Color(0xFF757575);

  // Input Colors
  static const Color darkInputFill = Color(0xFF2C2C2C);

  // Chip Colors
  static const Color lightChipBackground = Color(0xFFF5F5F5);
  static const Color darkChipBackground = Color(0xFF383838);

  // Admin Role Colors
  static const Color adminRole = Color(0xFFE57373); // Red 300
  static const Color userRole = Color(0xFF64B5F6); // Blue 300

  // Status Colors
  static const Color active = Color(0xFF4CAF50);
  static const Color inactive = Color(0xFF9E9E9E);
  static const Color pending = Color(0xFFFF9800);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}