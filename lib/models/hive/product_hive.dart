import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int categoryId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final String subtitle;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final String gender;
  @HiveField(7)
  final int price;
  @HiveField(8)
  final double rating;
  @HiveField(9)
  final bool isAvailable;
  @HiveField(10)
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'image': imageUrl,
      'subtitle': subtitle,
      'description': description,
      'gender': gender,
      'price': price,
      'rating': rating,
      'is_available': isAvailable,
      'product_details':
          productDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 1)
class DetailProduct {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int productId;
  @HiveField(2)
  final String size;
  @HiveField(3)
  final int stock;

  DetailProduct({
    required this.id,
    required this.productId,
    required this.size,
    required this.stock,
  });

  factory DetailProduct.fromJson(Map<String, dynamic> json) {
    return DetailProduct(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      size: json['size'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'size': size,
      'stock': stock,
    };
  }
}
