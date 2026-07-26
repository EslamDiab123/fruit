import 'package:flutter/material.dart';

import 'package:fruit/core/app_theme.dart';
import 'package:fruit/models.dart';

class ProductCard extends StatelessWidget {
  final Products product;
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
    final double w = MediaQuery.sizeOf(context).width;
    final bool isTabletOrWider = w >= tabletBreakpoint;

    final double favBtnSize = isTabletOrWider ? 36.0 : 30.0;
    final double favIconSize = isTabletOrWider ? 18.0 : 15.0;
    final double productNameSize = isTabletOrWider ? 15.5 : 15.0;
    final double productPriceSize = isTabletOrWider ? 15.5 : 16.0;
    final double ratingIconSize = isTabletOrWider ? 15.0 : 14.0;

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
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavouriteTap,
                    child: Container(
                      width: favBtnSize,
                      height: favBtnSize,
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
                        size: favIconSize,
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
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.productName.copyWith(
                      fontSize: productNameSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.ratingYellow,
                        size: ratingIconSize,
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
                          style: AppTextStyles.productPrice.copyWith(
                            fontSize: productPriceSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _CartControl(
                        quantity: cartQuantity,
                        onAdd: cartQuantity == 0 ? onAddToCart : onIncrement,
                        onRemove: onDecrement,
                        isTablet: isTabletOrWider,
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

class _CartControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isTablet;

  const _CartControl({
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final double btnH = isTablet ? 34.0 : 30.0;
    final double btnW = isTablet ? 32.0 : 28.0;
    final double plusSize = isTablet ? 20.0 : 18.0;
    final double innerSize = isTablet ? 16.0 : 15.0;
    final double countFont = isTablet ? 13.0 : 12.0;

    if (quantity == 0) {
      return GestureDetector(
        onTap: onAdd,
        child: Container(
          width: btnH,
          height: btnH,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(Icons.add, color: Colors.white, size: plusSize),
        ),
      );
    }

    return Container(
      height: btnH,
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: btnW,
              height: btnH,
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
                size: innerSize,
                color: quantity == 1 ? AppColors.errorRed : AppColors.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: countFont,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: btnW,
              height: btnH,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(9),
                ),
              ),
              child: Icon(Icons.add, size: innerSize, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
