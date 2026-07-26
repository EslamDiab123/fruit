import 'package:flutter/material.dart';

const double tabletBreakpoint = 600;
const double desktopBreakpoint = 1100;

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0CA201);
  static const Color primarySurface = Color(0xFFE8F5E9);

  static const Color surfaceWhite = Colors.white;
  static const Color cardBackground = Color(0xFFF2F2F2);
  static const Color divider = Color(0xFFE0E0E0);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textMuted = Color(0xFF9E9E9E);

  static const Color ratingYellow = Color(0xFFFFC107);
  static const Color errorRed = Color(0xFFE53935);
  static const Color badgeRed = Colors.red;

  static const Color shadowBlack = Color(0x14000000);
}

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle greeting = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle greetingSub = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle addressText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle seeAll = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle productName = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle productPrice = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle ratingText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle categoryLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle navLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle cartButton = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle basketItemName = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle basketItemPrice = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
}
