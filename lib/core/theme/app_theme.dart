import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppRadius {
  AppRadius._();
  static const double control = 16;
  static const double card = 20;
  static const double sheet = 24;
}

/// 8-pt grid.
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double s = 8;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppTheme {
  AppTheme._();

  // NOTE: `primary` / `error` / `onSurfaceVariant` use AA-safe shades for text and buttons.
  // The raw brand colours stay available in AppColors for rings, icons and large graphics.
  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryDark,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: Color(0xFF14573A),
    secondary: AppColors.accent,
    onSecondary: AppColors.textPrimary,
    secondaryContainer: Color(0xFFFFE8D6),
    onSecondaryContainer: Color(0xFF5A2A05),
    error: Color(0xFFC62F35),
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    surfaceContainerHighest: Color(0xFFEAF2EE),
    outline: Color(0xFF7F8F89),
    outlineVariant: AppColors.divider,
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkBackground,
    primaryContainer: Color(0xFF1F3A2F),
    onPrimaryContainer: AppColors.primaryContainer,
    secondary: AppColors.darkAccent,
    onSecondary: AppColors.darkBackground,
    secondaryContainer: Color(0xFF4A2E1A),
    onSecondaryContainer: Color(0xFFFFE8D6),
    error: Color(0xFFFF7A7F),
    onError: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkText,
    onSurfaceVariant: AppColors.darkTextSecondary,
    surfaceContainerHighest: Color(0xFF1F3029),
    outline: Color(0xFF6F847B),
    outlineVariant: AppColors.darkDivider,
  );

  static ThemeData light() => _build(_lightScheme, AppColors.background);
  static ThemeData dark() => _build(_darkScheme, AppColors.darkBackground);

  // Poppins for headings, Inter for body. Body text never goes below 14 sp.
  // TODO(Phase 7): bundle the fonts as assets so they also work on first launch offline.
  static TextStyle _poppins(double size, FontWeight weight, [double? height]) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: weight, height: height);
  static TextStyle _inter(double size, FontWeight weight, [double? height]) =>
      GoogleFonts.inter(fontSize: size, fontWeight: weight, height: height);

  static TextTheme _textTheme() => TextTheme(
        displayLarge: _poppins(48, FontWeight.w700, 1.1),
        displayMedium: _poppins(40, FontWeight.w700, 1.1),
        displaySmall: _poppins(32, FontWeight.w600, 1.15),
        headlineLarge: _poppins(28, FontWeight.w600, 1.2),
        headlineMedium: _poppins(24, FontWeight.w600, 1.25),
        headlineSmall: _poppins(22, FontWeight.w600, 1.25),
        titleLarge: _poppins(20, FontWeight.w600, 1.3),
        titleMedium: _inter(16, FontWeight.w600, 1.4),
        titleSmall: _inter(14, FontWeight.w600, 1.4),
        bodyLarge: _inter(16, FontWeight.w400, 1.5),
        bodyMedium: _inter(14, FontWeight.w400, 1.5),
        bodySmall: _inter(14, FontWeight.w400, 1.4),
        labelLarge: _inter(14, FontWeight.w600, 1.3),
        labelMedium: _inter(13, FontWeight.w500, 1.3),
        labelSmall: _inter(12, FontWeight.w500, 1.3),
      );

  static ThemeData _build(ColorScheme scheme, Color scaffold) {
    final textTheme = _textTheme().apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    final controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
    );
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: textTheme,
      dividerTheme: DividerThemeData(
          color: scheme.outlineVariant, space: 1, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 2,
        shadowColor: scheme.shadow.withValues(alpha: 0.10),
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 56),
          shape: controlShape,
          textStyle: _inter(16, FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: controlShape,
          side: BorderSide(color: scheme.outline),
          textStyle: _inter(16, FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: controlShape,
          textStyle: _inter(14, FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: border(scheme.outline),
        enabledBorder: border(scheme.outline),
        focusedBorder: border(scheme.primary, 2),
        errorBorder: border(scheme.error),
        focusedErrorBorder: border(scheme.error, 2),
        errorMaxLines: 3,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: scheme.outlineVariant),
        selectedColor: scheme.primaryContainer,
        backgroundColor: scheme.surface,
        checkmarkColor: scheme.primary,
        labelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: const CircleBorder(),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
