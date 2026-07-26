class Category {
  final String text;
  final String imageReference;

  const Category({required this.text, required this.imageReference});
}

class Product {
  final String name;
  final String imageReference;
  final double price;
  final double rate;

  const Product({
    required this.name,
    required this.imageReference,
    required this.price,
    required this.rate,
  });
}

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

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'price': price, 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      image: json['image'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
