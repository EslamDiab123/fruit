import 'package:flutter/material.dart';

import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';
import 'package:fruit/models.dart';

/// Responsive product card used in the home grid.
///
/// Inline quantity controls replace the old Positioned [AddtoCart] /
/// [RemoveFromCart] widgets, keeping the same cart logic but within a
/// self-contained card layout that works in a SliverGrid.
class ProductCard extends StatelessWidget {
  final Products product;

  /// 0 = not in cart; >0 = current quantity.
  final int cartQuantity;
  final bool isFavourite;
  final VoidCallback onAddToCart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onFavouriteTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.cartQuantity,
    required this.isFavourite,
    required this.onAddToCart,
    required this.onIncrement,
    required this.onDecrement,
    required this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowBlack,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image section ─────────────────────────────────────────────────
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Image.asset(
                        product.imageRefernce,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Favourite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavouriteTap,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        size: 15,
                        color: isFavourite
                            ? AppColors.errorRed
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ── Info section ──────────────────────────────────────────────────
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.ratingYellow,
                        size: 14,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product.rate.toStringAsFixed(1),
                        style: AppTextStyles.ratingText,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.productPrice,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _CartControl(
                        quantity: cartQuantity,
                        onAdd: cartQuantity == 0 ? onAddToCart : onIncrement,
                        onRemove: onDecrement,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Private cart-control widget ──────────────────────────────────────────────

/// Shows a single "+" button when [quantity] == 0, or a compact
/// decrement / count / increment control when [quantity] > 0.
///
/// Quantity never reaches negative: decrement at 1 removes the item entirely
/// (handled by the parent via [onRemove]).
class _CartControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _CartControl({
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return GestureDetector(
        onTap: onAdd,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 18),
        ),
      );
    }

    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement / delete
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28,
              height: 30,
              decoration: BoxDecoration(
                color: quantity == 1
                    ? AppColors.errorRed.withValues(alpha: 0.15)
                    : AppColors.primary.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(9),
                ),
              ),
              child: Icon(
                quantity == 1 ? Icons.delete_outline_rounded : Icons.remove,
                size: 15,
                color: quantity == 1 ? AppColors.errorRed : AppColors.primary,
              ),
            ),
          ),
          // Quantity count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          // Increment
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 28,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(9),
                ),
              ),
              child: const Icon(Icons.add, size: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
