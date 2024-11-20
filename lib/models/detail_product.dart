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

  DetailProduct copyWith({
    int? id,
    int? productId,
    String? size,
    int? stock,
  }) {
    return DetailProduct(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      stock: stock ?? this.stock,
    );
  }
}
