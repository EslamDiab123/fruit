import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';
import 'package:fruit/models.dart';

/// Floating cart-summary bar that hovers above the bottom navigation.
///
/// Shows thumbnails of items currently in the cart, a divider, a
/// "View Basket" button, and a total-quantity badge.  Uses [Expanded]
/// for the thumbnail list so it never overflows on any screen width.
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
          // ── Item thumbnails (scrollable, fills available space) ───────────
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
          // ── Divider ───────────────────────────────────────────────────────
          Container(
            width: 1,
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white.withValues(alpha: 0.4),
          ),
          // ── View Basket button ────────────────────────────────────────────
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
          // ── Total badge ───────────────────────────────────────────────────
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
