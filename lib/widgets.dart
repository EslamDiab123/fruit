import 'package:flutter/material.dart';

/// Legacy Positioned add-to-cart button.
///
/// Kept for backward compatibility; the new [ProductCard] widget contains
/// its own inline quantity controls and does not use this class.
class AddtoCart extends StatelessWidget {
  final VoidCallback? onTap;

  const AddtoCart({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: const Icon(Icons.add),
            iconSize: 30,
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}

/// Legacy Positioned quantity-control widget.
///
/// Kept for backward compatibility; the new [ProductCard] widget contains
/// its own inline quantity controls and does not use this class.
class RemoveFromCart extends StatelessWidget {
  final String q;
  final VoidCallback? onTapAdd;
  final VoidCallback? onTapRemove;

  const RemoveFromCart({
    super.key,
    required this.q,
    this.onTapAdd,
    this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: onTapRemove,
              icon: Image.asset(
                'assets/icons/trash-2.png',
                width: 18,
                height: 18,
              ),
            ),
            Text(
              q,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 24,
              onPressed: onTapAdd,
            ),
          ],
        ),
      ),
    );
  }
}
