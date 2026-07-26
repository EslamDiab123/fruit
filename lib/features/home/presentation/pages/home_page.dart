import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';
import 'package:fruit/features/home/data/home_data.dart';
import 'package:fruit/features/home/presentation/widgets/cart_bottom_bar.dart';
import 'package:fruit/features/home/presentation/widgets/category_item.dart';
import 'package:fruit/features/home/presentation/widgets/grocery_bottom_nav.dart';
import 'package:fruit/features/home/presentation/widgets/grocery_header.dart';
import 'package:fruit/features/home/presentation/widgets/product_card.dart';
import 'package:fruit/features/home/presentation/widgets/promo_banner.dart';
import 'package:fruit/features/home/presentation/widgets/search_field.dart';
import 'package:fruit/features/home/presentation/widgets/section_header.dart';
import 'package:fruit/models.dart';

/// The main Home Page for the Grabber grocery app.
///
/// Manages cart state (persisted via SharedPreferences), favourite state,
/// category selection and live product search filtering — all locally, with
/// no external dependencies beyond what already existed in the original code.
///
/// Set [enableBannerAutoPlay] to false in widget tests to prevent carousel
/// timers from blocking [WidgetTester.pump] calls.
class HomePage extends StatefulWidget {
  final bool enableBannerAutoPlay;

  const HomePage({super.key, this.enableBannerAutoPlay = true});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ── State ─────────────────────────────────────────────────────────────────
  List<CartItem> _cart = [];
  String _searchQuery = '';
  int _selectedNavIndex = 0;
  int _selectedCategoryIndex = 0;
  final Set<String> _favourites = {};
  final TextEditingController _searchController = TextEditingController();

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Cart persistence ──────────────────────────────────────────────────────

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cart');
    if (jsonString != null && mounted) {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      setState(() {
        _cart = decoded
            .map<CartItem>((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'cart',
      jsonEncode(_cart.map((e) => e.toJson()).toList()),
    );
  }

  // ── Cart mutations ────────────────────────────────────────────────────────

  void _addToCart(Products product) {
    setState(() {
      _cart.add(
        CartItem(
          image: product.imageRefernce,
          name: product.name,
          price: product.price,
          quantity: 1,
        ),
      );
    });
    _saveCart();
  }

  /// Increments the cart item at [cartIndex].
  void _incrementCart(int cartIndex) {
    setState(() {
      _cart[cartIndex].quantity++;
    });
    _saveCart();
  }

  /// Decrements the cart item at [cartIndex].
  /// Removes the item when quantity would reach 0 so it never goes negative.
  void _decrementCart(int cartIndex) {
    if (cartIndex < 0 || cartIndex >= _cart.length) return;
    setState(() {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    });
    _saveCart();
  }

  int _sumBadge() => _cart.fold(0, (sum, item) => sum + item.quantity);

  // ── Favourite ─────────────────────────────────────────────────────────────

  void _toggleFavourite(String productName) {
    setState(() {
      if (_favourites.contains(productName)) {
        _favourites.remove(productName);
      } else {
        _favourites.add(productName);
      }
    });
  }

  // ── Search ────────────────────────────────────────────────────────────────

  List<Products> get _filteredProducts {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return HomeData.products;
    return HomeData.products
        .where((p) => p.name.toLowerCase().contains(q))
        .toList();
  }

  // ── Basket sheet ──────────────────────────────────────────────────────────

  void _showBasketSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.55,
            minChildSize: 0.35,
            maxChildSize: 0.85,
            builder: (ctx, scrollController) => _BasketSheetContent(
              cart: _cart,
              scrollController: scrollController,
              onIncrement: (i) {
                if (i >= _cart.length) return;
                setSheetState(() => _cart[i].quantity++);
                setState(() {});
                _saveCart();
              },
              onDecrement: (i) {
                if (i >= _cart.length) return;
                setSheetState(() {
                  if (_cart[i].quantity > 1) {
                    _cart[i].quantity--;
                  } else {
                    _cart.removeAt(i);
                  }
                });
                setState(() {});
                _saveCart();
              },
            ),
          );
        },
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final List<Products> filtered = _filteredProducts;
    final bool hasCart = _cart.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      // Bottom nav lives outside the Stack so the body stops at its top edge.
      bottomNavigationBar: SafeArea(
        top: false,
        child: GroceryBottomNav(
          selectedIndex: _selectedNavIndex,
          onTap: (i) => setState(() => _selectedNavIndex = i),
        ),
      ),
      body: Stack(
        children: [
          // ── Scrollable content ─────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // Header (SafeArea covers status bar)
              SliverToBoxAdapter(
                child: SafeArea(bottom: false, child: const GroceryHeader()),
              ),

              // Search field — performs live filtering
              SliverToBoxAdapter(
                child: SearchField(
                  controller: _searchController,
                  onChanged: (q) => setState(() => _searchQuery = q),
                ),
              ),

              // Promotional banner
              SliverToBoxAdapter(
                child: PromoBanner(
                  bannerPaths: HomeData.banners,
                  enableAutoPlay: widget.enableBannerAutoPlay,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Categories
              const SliverToBoxAdapter(
                child: SectionHeader(title: 'Categories'),
              ),
              SliverToBoxAdapter(
                child: _CategoriesRow(
                  selectedIndex: _selectedCategoryIndex,
                  onCategoryTap: (i) =>
                      setState(() => _selectedCategoryIndex = i),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Products section header
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Fresh Products',
                  onActionTap: () {
                    // Placeholder – no full catalogue screen in scope
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // Product grid or empty state
              if (filtered.isEmpty)
                const SliverToBoxAdapter(child: _EmptySearchResult())
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = filtered[index];
                      final cartIndex = _cart.indexWhere(
                        (c) => c.name == product.name,
                      );
                      final qty = cartIndex == -1
                          ? 0
                          : _cart[cartIndex].quantity;
                      return ProductCard(
                        product: product,
                        cartQuantity: qty,
                        isFavourite: _favourites.contains(product.name),
                        onAddToCart: () => _addToCart(product),
                        onIncrement: () => _incrementCart(cartIndex),
                        onDecrement: () => _decrementCart(cartIndex),
                        onFavouriteTap: () => _toggleFavourite(product.name),
                      );
                    }, childCount: filtered.length),
                    // Adapts naturally: 2 columns on phones, more on tablets.
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                  ),
                ),

              // Extra bottom padding so last cards are never hidden behind
              // the floating cart bar or the bottom nav bar.
              SliverToBoxAdapter(child: SizedBox(height: hasCart ? 100 : 28)),
            ],
          ),

          // ── Floating cart bar ──────────────────────────────────────────
          if (hasCart)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: CartBottomBar(
                  cart: _cart,
                  totalQuantity: _sumBadge(),
                  onViewBasket: _showBasketSheet,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Private helper widgets ───────────────────────────────────────────────────

class _CategoriesRow extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onCategoryTap;

  const _CategoriesRow({
    required this.selectedIndex,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: List.generate(HomeData.categories.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              category: HomeData.categories[i],
              isSelected: selectedIndex == i,
              onTap: () => onCategoryTap(i),
            ),
          );
        }),
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: AppColors.textMuted),
          SizedBox(height: 12),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Try a different search term',
            style: TextStyle(fontSize: 14, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

// ─── Basket bottom sheet ──────────────────────────────────────────────────────

class _BasketSheetContent extends StatelessWidget {
  final List<CartItem> cart;
  final ScrollController scrollController;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;

  const _BasketSheetContent({
    required this.cart,
    required this.scrollController,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Handle
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Basket', style: AppTextStyles.heading2),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        if (cart.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'Your basket is empty',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: cart.length,
              itemBuilder: (ctx, i) => _BasketItem(
                item: cart[i],
                onIncrement: () => onIncrement(i),
                onDecrement: () => onDecrement(i),
              ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _BasketItem extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _BasketItem({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(item.image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.basketItemName),
                const SizedBox(height: 4),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: AppTextStyles.basketItemPrice,
                ),
              ],
            ),
          ),
          // Quantity controls — quantity never goes negative
          _BasketQuantityControl(
            quantity: item.quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}

class _BasketQuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _BasketQuantityControl({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrement,
            icon: Icon(
              quantity == 1 ? Icons.delete_outline_rounded : Icons.remove,
              color: quantity == 1 ? AppColors.errorRed : AppColors.primary,
              size: 18,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(Icons.add, color: AppColors.primary, size: 18),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
          ),
        ],
      ),
    );
  }
}
