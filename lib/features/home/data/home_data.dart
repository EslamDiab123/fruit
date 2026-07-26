import 'package:fruit/models.dart';

/// Metadata for a single promotional banner slide.
class BannerItem {
  final String imagePath;

  /// Short headline shown as a text overlay on the banner card.
  final String headline;

  /// Supporting sub-line shown below the headline.
  final String subtext;

  const BannerItem({
    required this.imagePath,
    required this.headline,
    required this.subtext,
  });
}

/// Static mock data for the Home Page.
///
/// Extracted from the original [HomeScreen] static lists so the page widget
/// has no knowledge of raw data.  Field names deliberately match the existing
/// model typos (imageReferance, imageRefernce) to avoid breaking changes.
class HomeData {
  HomeData._();

  /// Banner slides with corrected promotional text.
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

  /// Backward-compatible list of image paths for external callers.
  static List<String> get banners =>
      bannerItems.map((b) => b.imagePath).toList();

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
