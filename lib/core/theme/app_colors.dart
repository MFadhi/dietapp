import 'package:flutter/material.dart';

/// Raw palette from the design spec.
class AppColors {
  AppColors._();

  // ---- Light ----
  static const primary = Color(0xFF2E9E6B); // brand green: rings, icons, large graphics
  static const primaryDark = Color(0xFF1F7A51); // pressed + AA-safe for text/buttons
  static const primaryContainer = Color(0xFFDDF4E8);
  static const accent = Color(0xFFFF8A3D);
  static const background = Color(0xFFF6FAF7);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1F2D2A);
  // Spec value #6B7C76 is ~4.2:1 on the background; darkened slightly to pass WCAG AA (4.5:1).
  static const textSecondary = Color(0xFF5F706A);
  static const divider = Color(0xFFE3ECE7);

  static const success = Color(0xFF2E9E6B);
  static const warning = Color(0xFFF5B83D);
  static const error = Color(0xFFE5484D);
  static const info = Color(0xFF4C8DFF);

  // ---- Macros ----
  static const protein = Color(0xFF4C8DFF);
  static const carbs = Color(0xFFFFB347);
  static const fat = Color(0xFFB388EB);
  static const fibre = Color(0xFF2E9E6B);
  static const water = Color(0xFF4FC3F7);

  // ---- Dark ----
  static const darkBackground = Color(0xFF0F1A17);
  static const darkSurface = Color(0xFF16241F);
  static const darkPrimary = Color(0xFF4CC38A);
  static const darkAccent = Color(0xFFFF9F5A);
  static const darkText = Color(0xFFE8F1EC);
  static const darkTextSecondary = Color(0xFF9DB0A8);
  static const darkDivider = Color(0xFF263A33);
}
