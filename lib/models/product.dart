class Product {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String subtitle;
  final String description;
  final String gender;
  final int price;
  final double rating; // Menggunakan 'double' karena 'float' tidak tersedia di Dart

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
  });

  Product copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? imageUrl,
    String? subtitle,
    String? description,
    String? gender,
    int? price,
    double? rating,
  }) {
    return Product(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      gender: gender ?? this.gender,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }
}
