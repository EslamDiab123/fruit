import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/app_theme.dart';
import 'package:fruit/models.dart';

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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isTablet =
        screenWidth >= tabletBreakpoint && screenWidth <= desktopBreakpoint;

    final List<_NavItemData> items = [
      _NavItemData(
        label: 'Home',
        icon: const Icon(Icons.home_outlined, size: 26),
        selectedIcon: const Icon(
          Icons.home_filled,
          size: 26,
          color: AppColors.primary,
        ),
      ),
      _NavItemData(
        label: 'Favourite',
        icon: const Icon(Icons.favorite_border, size: 26),
        selectedIcon: const Icon(
          Icons.favorite,
          size: 26,
          color: AppColors.primary,
        ),
      ),
      _NavItemData(
        label: 'Search',
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
      _NavItemData(
        label: 'Profile',
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
      _NavItemData(
        label: 'Menu',
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

    final Widget navRow = Row(
      children: List.generate(items.length, (i) {
        return _NavItem(
          index: i,
          label: items[i].label,
          selectedIndex: selectedIndex,
          onTap: onTap,
          icon: items[i].icon,
          selectedIcon: items[i].selectedIcon,
          isTablet: isTablet,
        );
      }),
    );

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
      child: isTablet
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: navRow,
              ),
            )
          : navRow,
    );
  }
}

class _NavItemData {
  final String label;
  final Widget icon;
  final Widget selectedIcon;

  const _NavItemData({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

class _NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final ValueChanged<int> onTap;
  final bool isTablet;

  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    final double labelSize = isTablet ? 11.5 : 10.0;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

class CartBottomBar extends StatelessWidget {
  final List<CartItem> cart;
  final int totalQuantity;
  final VoidCallback onViewBasket;

  const CartBottomBar({
    super.key,
    required this.cart,
    required this.totalQuantity,
    required this.onViewBasket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primary.withValues(alpha: 0.96),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: cart.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Badge(
                      backgroundColor: AppColors.badgeRed,
                      textColor: Colors.white,
                      label: Text(
                        item.quantity.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(item.image, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white.withValues(alpha: 0.4),
          ),
          GestureDetector(
            onTap: onViewBasket,
            behavior: HitTestBehavior.opaque,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View Basket', style: AppTextStyles.cartButton),
                SizedBox(width: 5),
                Icon(
                  Icons.shopping_basket_outlined,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Badge(
            backgroundColor: AppColors.badgeRed,
            textColor: Colors.white,
            label: Text('$totalQuantity', style: const TextStyle(fontSize: 10)),
            child: SvgPicture.asset(
              'assets/icons/Icons.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
