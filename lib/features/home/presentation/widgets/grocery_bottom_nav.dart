import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/constants/app_breakpoints.dart';
import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';

/// Five-tab bottom navigation bar preserving the original visual identity:
/// a full-width 3 px green line appears above the selected tab.
///
/// On tablets (≥ 600 px) the tab row is constrained to 680 px and centred so
/// the items are not spread uselessly across the full iPad width.
class GroceryBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const GroceryBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    final bool isTabletOrWider = w >= AppBreakpoints.tablet;
    final double labelSize = isTabletOrWider ? 11.5 : 10.0;

    final List<Widget> navItems = [
      _NavItem(
        index: 0,
        label: 'Home',
        selectedIndex: selectedIndex,
        onTap: onTap,
        labelSize: labelSize,
        icon: const Icon(Icons.home_outlined, size: 26),
        selectedIcon: const Icon(
          Icons.home_filled,
          size: 26,
          color: AppColors.primary,
        ),
      ),
      _NavItem(
        index: 1,
        label: 'Favourite',
        selectedIndex: selectedIndex,
        onTap: onTap,
        labelSize: labelSize,
        icon: const Icon(Icons.favorite_border, size: 26),
        selectedIcon: const Icon(
          Icons.favorite,
          size: 26,
          color: AppColors.primary,
        ),
      ),
      _NavItem(
        index: 2,
        label: 'Search',
        selectedIndex: selectedIndex,
        onTap: onTap,
        labelSize: labelSize,
        icon: SvgPicture.asset(
          'assets/icons/Search.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        ),
        selectedIcon: SvgPicture.asset(
          'assets/icons/Search.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
      _NavItem(
        index: 3,
        label: 'Profile',
        selectedIndex: selectedIndex,
        onTap: onTap,
        labelSize: labelSize,
        icon: SvgPicture.asset(
          'assets/icons/Profile.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        ),
        selectedIcon: SvgPicture.asset(
          'assets/icons/Profile.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
      _NavItem(
        index: 4,
        label: 'Menu',
        selectedIndex: selectedIndex,
        onTap: onTap,
        labelSize: labelSize,
        icon: SvgPicture.asset(
          'assets/icons/Menue.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        ),
        selectedIcon: SvgPicture.asset(
          'assets/icons/Menue.svg',
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    ];

    // On tablet: the row is constrained + centred; the Container still spans
    // the full width so the white background and shadow fill edge-to-edge.
    final Widget tabRow = Row(children: navItems);

    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlack,
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: isTabletOrWider
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: tabRow,
              ),
            )
          : tabRow,
    );
  }
}

// ─── Private nav-item ─────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final double labelSize;
  final Widget icon;
  final Widget selectedIcon;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.labelSize,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full-width 3 px indicator line (matches original design)
            Container(
              height: 3,
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSelected ? selectedIcon : icon,
                  const SizedBox(height: 3),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.navLabel.copyWith(
                      fontSize: labelSize,
                      color: isSelected ? AppColors.primary : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
