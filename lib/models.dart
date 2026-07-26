class Category {
  final String text;
  final String imageReferance;
  const Category({required this.text, required this.imageReferance});
}

class Products {
  final String name;
  final String imageRefernce;
  final double price;
  final double rate;
  const Products({
    required this.name,
    required this.imageRefernce,
    required this.price,
    required this.rate,
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
