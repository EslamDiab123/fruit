import 'package:fruit/models.dart';

class BannerItem {
  final String imagePath;
  final String headline;
  final String subtext;

  const BannerItem({
    required this.imagePath,
    required this.headline,
    required this.subtext,
  });
}

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
      imageReferance: 'assets/Category/Beverages.png',
    ),
    Category(text: 'Fruits', imageReferance: 'assets/Category/fruits.png'),
    Category(text: 'Laundry', imageReferance: 'assets/Category/Laundry.png'),
    Category(
      text: 'Milk & Egg',
      imageReferance: 'assets/Category/Milk&egg.png',
    ),
    Category(
      text: 'Vegetables',
      imageReferance: 'assets/Category/Vegetabls.png',
    ),
  ];

  static const List<Products> products = [
    Products(
      imageRefernce: 'assets/fruits/Banana.png',
      name: 'Banana',
      price: 3.99,
      rate: 4.8,
    ),
    Products(
      imageRefernce: 'assets/fruits/Limon.png',
      name: 'Lemon',
      price: 2.99,
      rate: 4.8,
    ),
    Products(
      imageRefernce: 'assets/fruits/Orange.png',
      name: 'Orange',
      price: 2.99,
      rate: 4.8,
    ),
    Products(
      imageRefernce: 'assets/fruits/Pepper.png',
      name: 'Pepper',
      price: 2.99,
      rate: 4.8,
    ),
  ];
}
