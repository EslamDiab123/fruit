import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fruit/features/home/data/home_data.dart';
import 'package:fruit/features/home/models/home_models.dart';

class HomeViewModel extends ChangeNotifier {
  List<CartItem> _cart = [];
  String _searchQuery = '';
  int _selectedNavIndex = 0;
  int _selectedCategoryIndex = 0;
  final Set<String> _favourites = {};

  List<CartItem> get cart => _cart;
  int get selectedNavIndex => _selectedNavIndex;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  bool get hasCart => _cart.isNotEmpty;
  int get totalQuantity => _cart.fold(0, (sum, item) => sum + item.quantity);

  List<Product> get filteredProducts {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return HomeData.products;

    return HomeData.products
        .where((product) => product.name.toLowerCase().contains(query))
        .toList();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCart = prefs.getString('cart');
    if (savedCart == null) return;

    final decoded = jsonDecode(savedCart) as List<dynamic>;
    _cart = decoded
        .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  void selectNavItem(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  bool isFavourite(Product product) => _favourites.contains(product.name);

  void toggleFavourite(Product product) {
    if (!_favourites.remove(product.name)) {
      _favourites.add(product.name);
    }
    notifyListeners();
  }

  int cartQuantity(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);
    return index == -1 ? 0 : _cart[index].quantity;
  }

  void addToCart(Product product) {
    _cart.add(
      CartItem(
        image: product.imageReference,
        name: product.name,
        price: product.price,
        quantity: 1,
      ),
    );
    _cartChanged();
  }

  void incrementProduct(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);
    if (index == -1) {
      addToCart(product);
      return;
    }

    _cart[index].quantity++;
    _cartChanged();
  }

  void decrementProduct(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);
    if (index != -1) decrementCartItem(index);
  }

  void incrementCartItem(int index) {
    if (index < 0 || index >= _cart.length) return;
    _cart[index].quantity++;
    _cartChanged();
  }

  void decrementCartItem(int index) {
    if (index < 0 || index >= _cart.length) return;

    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
    } else {
      _cart.removeAt(index);
    }
    _cartChanged();
  }

  void _cartChanged() {
    notifyListeners();
    _saveCart();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'cart',
      jsonEncode(_cart.map((item) => item.toJson()).toList()),
    );
  }
}
