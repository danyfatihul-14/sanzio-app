import 'package:hive/hive.dart';

part 'model.g.dart';

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
  @HiveField(11)
  // ignore: non_constant_identifier_names
  final List<SkinType> skin_type;

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
    // ignore: non_constant_identifier_names
    required this.skin_type,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var details = json['product_details'] as List;
    List<DetailProduct> detailList =
        details.map((i) => DetailProduct.fromJson(i)).toList();
    var skinType = json['skin_type'] as List;
    List<SkinType> skinList =
        skinType.map((i) => SkinType.fromJson(i)).toList();

    return Product(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      title: json['title'],
      imageUrl: json['image'],
      subtitle: json['subtitle'],
      description: json['description'],
      gender: json['gender'],
      price: json['price'],
      rating: json['rating'],
      isAvailable: json['is_available'],
      productDetails: detailList,
      skin_type: skinList,
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
      'skin_type': skin_type.map((skin) => skin.toJson()).toList(),
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

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final int addressId;
  @HiveField(3)
  final String orderCode;
  @HiveField(4)
  final int amount;
  @HiveField(5)
  final DateTime orderDate;
  @HiveField(6)
  final DateTime? paidDate;
  @HiveField(7)
  final DateTime? finishAt;
  @HiveField(8)
  final bool isPaid;
  @HiveField(9)
  final bool isCancel;
  @HiveField(10)
  final List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.orderCode,
    required this.amount,
    required this.orderDate,
    this.paidDate,
    this.finishAt,
    required this.isPaid,
    required this.isCancel,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var details = json['order_details'] as List;
    List<OrderDetail> detailList =
        details.map((i) => OrderDetail.fromJson(i)).toList();

    return Order(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      orderCode: json['order_code'],
      amount: json['amount'],
      orderDate: DateTime.parse(json['order_date']),
      paidDate:
          json['paid_date'] != null ? DateTime.parse(json['paid_date']) : null,
      finishAt:
          json['finish_at'] != null ? DateTime.parse(json['finish_at']) : null,
      isPaid: json['is_paid'],
      isCancel: json['is_cancel'],
      orderDetails: detailList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address_id': addressId,
      'order_code': orderCode,
      'amount': amount,
      'order_date': orderDate.toIso8601String(),
      'paid_date': paidDate?.toIso8601String(),
      'finish_at': finishAt?.toIso8601String(),
      'is_paid': isPaid,
      'is_cancel': isCancel,
      'order_details': orderDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 3)
class OrderDetail {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final ProductDetailRequest productDetail;

  OrderDetail({
    required this.id,
    required this.amount,
    required this.productDetail,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      amount: json['amount'],
      productDetail: ProductDetailRequest.fromJson(json['product_detail']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'product_detail': productDetail.toJson(),
    };
  }
}

@HiveType(typeId: 4)
class ProductDetailRequest {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String size;
  @HiveField(2)
  final ProductRequest product;

  ProductDetailRequest({
    required this.id,
    required this.size,
    required this.product,
  });

  factory ProductDetailRequest.fromJson(Map<String, dynamic> json) {
    return ProductDetailRequest(
      id: json['id'],
      size: json['size'],
      product: ProductRequest.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'product': product.toJson(),
    };
  }
}

@HiveType(typeId: 5)
class ProductRequest {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final String image;

  ProductRequest({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory ProductRequest.fromJson(Map<String, dynamic> json) {
    return ProductRequest(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }
}

enum Gender {
  M,
  W,
}

@HiveType(typeId: 6)
class User {
  @HiveField(0)
  final String? username;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final String? fullname;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  Gender? gender;

  User({
    this.username,
    this.email,
    this.phone,
    this.fullname,
    this.image,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullname: json['fullname'],
      image: json['image'] != null ? json['image'] : null,
      phone: json['telp'] != null ? json['telp'] : null,
      email: json['email'],
      gender: User.jsonToGender(json['gender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'image': image,
      'gender': gender
    };
  }

  static Gender? jsonToGender(String? genderString) {
    switch (genderString) {
      case 'M':
        return Gender.M;
      case 'W':
        return Gender.W;
      default:
        return null;
    }
  }

  static Gender? stringToGender(String? genderString) {
    switch (genderString) {
      case 'Man':
        return Gender.M;
      case 'Woman':
        return Gender.W;
      default:
        return null;
    }
  }

  static String? genderToString(Gender? gender) {
    switch (gender) {
      case Gender.M:
        return 'Man';
      case Gender.W:
        return 'Woman';
      default:
        return null;
    }
  }
}

@HiveType(typeId: 7)
class Address extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  String address;
  @HiveField(2)
  bool isDefault;

  Address({
    required this.id,
    required this.address,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address: json['address'],
      isDefault: json['is_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'isDefault': isDefault,
    };
  }
}

@HiveType(typeId: 8)
class CartHive extends HiveObject {
  @HiveField(0)
  final int detailProductId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final String size;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  int quantity;
  @HiveField(6)
  String status;
  @HiveField(7)
  bool isSelected;
  @HiveField(8)
  int stock;

  CartHive(
      {required this.detailProductId,
      required this.title,
      required this.price,
      required this.size,
      required this.imageUrl,
      this.quantity = 1,
      this.status = 'In Cart',
      this.isSelected = false,
      this.stock = 1});
}

@HiveType(typeId: 9)
class SkinType extends HiveObject {
  @HiveField(0)
  // ignore: non_constant_identifier_names
  final int skin_type;

  // ignore: non_constant_identifier_names
  SkinType({required this.skin_type});

  factory SkinType.fromJson(Map<String, dynamic> json) {
    return SkinType(skin_type: json['skin_type'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'skin_type': skin_type,
    };
  }

  static String numToHexcode(int num) {
    switch (num) {
      case 0:
        return "f6ede4";
      case 1:
        return "f3e7db";
      case 2:
        return "f7ead0";
      case 3:
        return "eadaba";
      case 4:
        return "d7bd96";
      case 5:
        return "a07d56";
      case 6:
        return "825c43";
      case 7:
        return "604134";
      case 8:
        return "3a312a";
      case 9:
        return "292420";
      default:
        return "Unknown";
    }
  }
}
