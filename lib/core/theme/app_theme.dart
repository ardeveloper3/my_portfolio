// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bgPrimary = Color(0xFF050A14);
  static const Color bgSecondary = Color(0xFF0A1628);
  static const Color bgCard = Color(0xFF0D1B2E);
  static const Color bgGlass = Color(0x1A00D4FF);

  // Accents
  static const Color cyan = Color(0xFF00D4FF);
  static const Color cyanGlow = Color(0x4000D4FF);
  static const Color cyanDim = Color(0xFF0099BB);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleGlow = Color(0x408B5CF6);
  static const Color purpleDim = Color(0xFF6D28D9);
  static const Color pink = Color(0xFFEC4899);

  // Text
  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF475569);

  // Borders
  static const Color borderGlass = Color(0x2200D4FF);
  static const Color borderSubtle = Color(0x1AFFFFFF);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF050A14), Color(0xFF0A1020), Color(0xFF050A14)],
  );

  static const LinearGradient cyanPurpleGradient = LinearGradient(
    colors: [cyan, purple],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1A00D4FF), Color(0x0A8B5CF6)],
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.cyan,
        secondary: AppColors.purple,
        surface: AppColors.bgSecondary,
        background: AppColors.bgPrimary,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -2,
            height: 1.1,
          ),
          displayMedium: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          displaySmall: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -1,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
