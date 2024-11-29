class OrderForm {
  final int addressId;
  final List<OrderDetailForm> detailProducts;

  OrderForm({
    required this.addressId,
    required this.detailProducts,
  });

  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'order_details': detailProducts.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderDetailForm {
  final int detailId;
  final int amount;

  OrderDetailForm({
    required this.detailId,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_detail_id': detailId,
      'amount': amount,
    };
  }
}
