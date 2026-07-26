import 'package:flutter/material.dart';

/// Central color palette for the Grabber grocery app.
///
/// Use these constants throughout the app instead of hardcoding hex values.
class AppColors {
  AppColors._();

  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF0CA201);
  static const Color primaryDark = Color(0xFF087A01);
  static const Color primarySurface = Color(0xFFE8F5E9);

  // ── Neutrals ───────────────────────────────────────────────────────────────
  static const Color surfaceWhite = Colors.white;
  static const Color cardBackground = Color(0xFFF2F2F2);
  static const Color divider = Color(0xFFE0E0E0);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textMuted = Color(0xFF9E9E9E);

  // ── Accents ────────────────────────────────────────────────────────────────
  static const Color ratingYellow = Color(0xFFFFC107);
  static const Color errorRed = Color(0xFFE53935);
  static const Color badgeRed = Colors.red;

  // ── Shadows ────────────────────────────────────────────────────────────────
  /// 8 % black — used in BoxShadow so it can stay const.
  static const Color shadowBlack = Color(0x14000000);
}
