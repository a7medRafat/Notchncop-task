import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Brand / primary
  static const Color primary = Colors.indigo;

  /// Text
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6E6E73);
  static const Color textMuted = Color(0xFF8E8E93);

  /// Surfaces
  static const Color background = Color(0xFFF9F9FB);
  static const Color surface = Colors.white;

  /// Borders & dividers
  static const Color border = Color(0xFFE5E5EA);

  /// Rating
  static const Color ratingStar = Color(0xFFFFC107);
  static const Color ratingBadgeBg = Color(0xCC000000);

  /// Favorites
  static const Color favoriteActive = Color(0xFFE53935);
  static const Color favoriteInactive = Colors.white;

  /// Shimmer / skeleton
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  /// Chips
  static const Color chipBackground = Color(0xFFF2F2F7);
  static const Color chipBorder = Color(0xFFE5E5EA);

  /// Error
  static const Color error = Color(0xFFD32F2F);
}
