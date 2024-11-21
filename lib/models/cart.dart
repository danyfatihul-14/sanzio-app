class Cart {
  final int detailProductId;
  final String title;
  final int price;
  final String size;
  final String imageUrl;
  int quantity;
  String status;
  bool isSelected;
  int stock;

  Cart({
    required this.detailProductId,
    required this.title,
    required this.price,
    required this.size,
    required this.imageUrl,
    this.quantity = 1,
    this.status = 'In Cart',
    this.isSelected = false,
    this.stock = 1
  });
}
