class DetailProduct {
  final int id;
  final int productId;
  final String size;
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
}
