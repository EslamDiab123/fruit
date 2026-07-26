import 'package:fruit/models.dart';

/// Static mock data for the Home Page.
///
/// Extracted from the original [HomeScreen] static lists so the page widget
/// has no knowledge of raw data.  Field names deliberately match the existing
/// model typos (imageReferance, imageRefernce) to avoid breaking changes.
class HomeData {
  HomeData._();

  static const List<String> banners = [
    'assets/banners/Slider 1.png',
    'assets/banners/Slider 2.png',
    'assets/banners/Slider 3.png',
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
