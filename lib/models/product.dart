import 'package:raffaelosanzio/models/detail_product.dart';

class Product {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String subtitle;
  final String description;
  final String gender;
  final int price;
  final double rating;
  final bool isAvailable;
  final List<DetailProduct> productDetails;

  Product({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    required this.description,
    required this.gender,
    required this.price,
    required this.rating,
    required this.isAvailable,
    required this.productDetails,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var details = json['product_details'] as List;
    List<DetailProduct> detailList =
        details.map((i) => DetailProduct.fromJson(i)).toList();

    return Product(
      id: json['id'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      title: json['title'],
      imageUrl: json['image'],
      subtitle: json['subtitle'],
      description: json['description'],
      gender: json['gender'],
      price: json['price'],
      rating: json['rating'],
      isAvailable: json['is_available'],
      productDetails: detailList,
    );
  }
}
