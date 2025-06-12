import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mouthooq/resources/themes/app_colors.dart';

class AppTextStyles {
  // Private constructor
  AppTextStyles._();

  // Display Styles
  static TextStyle displayLarge = GoogleFonts.cairo(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = GoogleFonts.cairo(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displaySmall = GoogleFonts.cairo(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  // Headline Styles
  static TextStyle headlineLarge = GoogleFonts.cairo(
    fontSize: 32,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineMedium = GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineSmall = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  // Title Styles
  static TextStyle titleLarge = GoogleFonts.cairo(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleMedium = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Body Styles
  static TextStyle bodyLarge = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static TextStyle bodySmall = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Label Styles
  static TextStyle labelLarge = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.cairo(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Component Specific Styles
  static TextStyle appBarTitle = GoogleFonts.cairo(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle buttonText = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle inputLabel = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle inputHint = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle inputError = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static TextStyle navLabel = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle chipLabel = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle dialogTitle = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static TextStyle dialogContent = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle snackBarContent = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // Custom App Styles
  static TextStyle cardTitle = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle cardSubtitle = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle userRole = GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle formFieldLabel = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle errorMessage = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static TextStyle successMessage = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.success,
  );

  static TextStyle warningMessage = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.warning,
  );
}