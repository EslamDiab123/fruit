import 'package:fruit/features/home/models/home_models.dart';

class HomeData {
  HomeData._();

  static const List<BannerItem> bannerItems = [
    BannerItem(
      imagePath: 'assets/banners/Slider 1.png',
      headline: 'Get same-day delivery',
      subtext: 'On orders over \$20',
    ),
    BannerItem(
      imagePath: 'assets/banners/Slider 2.png',
      headline: 'Save big on fresh groceries',
      subtext: 'Up to 30% off',
    ),
    BannerItem(
      imagePath: 'assets/banners/Slider 3.png',
      headline: 'For first-time buyers',
      subtext: 'Up to 25% off',
    ),
  ];

  static const List<Category> categories = [
    Category(
      text: 'Beverages',
      imageReference: 'assets/Category/Beverages.png',
    ),
    Category(text: 'Fruits', imageReference: 'assets/Category/fruits.png'),
    Category(text: 'Laundry', imageReference: 'assets/Category/Laundry.png'),
    Category(
      text: 'Milk & Egg',
      imageReference: 'assets/Category/Milk&egg.png',
    ),
    Category(
      text: 'Vegetables',
      imageReference: 'assets/Category/Vegetabls.png',
    ),
  ];

  static const List<Product> products = [
    Product(
      imageReference: 'assets/fruits/Banana.png',
      name: 'Banana',
      price: 3.99,
      rate: 4.8,
    ),
    Product(
      imageReference: 'assets/fruits/Limon.png',
      name: 'Lemon',
      price: 2.99,
      rate: 4.8,
    ),
    Product(
      imageReference: 'assets/fruits/Orange.png',
      name: 'Orange',
      price: 2.99,
      rate: 4.8,
    ),
    Product(
      imageReference: 'assets/fruits/Pepper.png',
      name: 'Pepper',
      price: 2.99,
      rate: 4.8,
    ),
  ];
}
