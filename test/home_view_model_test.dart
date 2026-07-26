import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fruit/features/home/data/home_data.dart';
import 'package:fruit/features/home/view_models/home_view_model.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('filters products by search text', () {
    final viewModel = HomeViewModel();
    addTearDown(viewModel.dispose);

    viewModel.setSearchQuery('banana');

    expect(viewModel.filteredProducts, hasLength(1));
    expect(viewModel.filteredProducts.first.name, 'Banana');
  });

  test('toggles product favourites', () {
    final viewModel = HomeViewModel();
    final product = HomeData.products.first;
    addTearDown(viewModel.dispose);

    viewModel.toggleFavourite(product);
    expect(viewModel.isFavourite(product), isTrue);

    viewModel.toggleFavourite(product);
    expect(viewModel.isFavourite(product), isFalse);
  });

  test('updates cart quantity without going below zero', () async {
    final viewModel = HomeViewModel();
    final product = HomeData.products.first;
    addTearDown(viewModel.dispose);

    viewModel.addToCart(product);
    viewModel.incrementProduct(product);
    expect(viewModel.cartQuantity(product), 2);
    expect(viewModel.totalQuantity, 2);

    viewModel.decrementProduct(product);
    viewModel.decrementProduct(product);
    expect(viewModel.cartQuantity(product), 0);
    expect(viewModel.hasCart, isFalse);

    await Future<void>.delayed(Duration.zero);
  });
}
