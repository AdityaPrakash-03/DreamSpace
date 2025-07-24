
class Product {
  final String name;
  final String price;
  final String imageUrl;
  final String purchaseUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.purchaseUrl,
  });

  // Factory constructor to create a Product from JSON data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['product_name'] ?? 'No Name',
      price: json['price'] ?? 'N/A',
      imageUrl: json['image_url'] ?? '',
      purchaseUrl: json['purchase_link'] ?? '#',
    );
  }
}
