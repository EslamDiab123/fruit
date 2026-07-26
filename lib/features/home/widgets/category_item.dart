import 'package:flutter/material.dart';

import 'package:fruit/core/app_theme.dart';
import 'package:fruit/models.dart';

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
    final bool isTablet = w >= tabletBreakpoint && w <= desktopBreakpoint;

    final double tileSize = isTablet ? 86.0 : 66.0;
    final double containerWidth = isTablet ? 100.0 : 84.0;
    final double labelFontSize = isTablet ? 13.0 : 11.0;
    final double borderRadius = isTablet ? 22.0 : 18.0;
    final double iconPadding = isTablet ? 14.0 : 10.0;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: containerWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: tileSize,
              height: tileSize,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primarySurface
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(iconPadding),
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
                fontSize: labelFontSize,
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
