class DetailProduct {
  final String name;
  final String price;
  final String imageUrl;
  final String description1;
  final String description2;
  String size;
  int quantity;

  DetailProduct({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description1,
    required this.description2,
    this.size = 'S',
    this.quantity = 1,
  });

  DetailProduct copyWith({
    String? name,
    String? price,
    String? imageUrl,
    String? description1,
    String? description2,
    String? size,
    int? quantity,
  }) {
    return DetailProduct(
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description1: description1 ?? this.description1,
      description2: description2 ?? this.description2,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}