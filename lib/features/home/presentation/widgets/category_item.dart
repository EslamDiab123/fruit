import 'package:flutter/material.dart';

import 'package:fruit/core/constants/app_breakpoints.dart';
import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';
import 'package:fruit/models.dart';

/// A single tappable category tile: rounded image container + label.
///
/// Tile size scales from 66 px (mobile) to 84 px (tablet+) automatically.
class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    final bool isTabletOrWider = w >= AppBreakpoints.tablet;

    final double containerSize = isTabletOrWider ? 80.0 : 66.0;
    final double containerRadius = isTabletOrWider ? 22.0 : 18.0;
    final double itemWidth = isTabletOrWider ? 96.0 : 84.0;
    final double imagePad = isTabletOrWider ? 12.0 : 10.0;
    final double labelSize = isTabletOrWider ? 12.0 : 11.0;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primarySurface
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(containerRadius),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(imagePad),
                child: Image.asset(
                  category.imageReferance,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              category.text,
              style: AppTextStyles.categoryLabel.copyWith(
                fontSize: labelSize,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
