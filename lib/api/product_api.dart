import 'package:raffaelosanzio/models/detail_product.dart';
import 'package:raffaelosanzio/models/product.dart';

// List of Products
final List<Product> products = [
  Product(
      id: 1,
      categoryId: 1,
      title: "Jacket Bomber",
      imageUrl: "assets/JacketBomber.png",
      subtitle: "Jacket Bomber dengan style retro",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      gender: "M",
      price: 150000,
      rating: 4.8),
  Product(
      id: 2,
      categoryId: 2,
      title: "Daster",
      imageUrl: "assets/Daster.png",
      subtitle: "Jacket Bomber dengan style retro",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      gender: "M",
      price: 150000,
      rating: 4.8),
  Product(
      id: 3,
      categoryId: 3,
      title: "Tank Top",
      imageUrl: "assets/Tanktop.png",
      subtitle: "Jacket Bomber dengan style retro",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      gender: "M",
      price: 150000,
      rating: 4.8),
  Product(
      id: 4,
      categoryId: 4,
      title: "Batik Shirt",
      imageUrl: "assets/Batik.png",
      subtitle: "Jacket Bomber dengan style retro",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      gender: "M",
      price: 150000,
      rating: 4.8),
  // Tambahkan produk lain sesuai kebutuhan
];

// List of Detail Products
final List<DetailProduct> detailProducts = [
  // Id 1
  DetailProduct(id: 1, productId: 1, size: "S", stock: 10),
  DetailProduct(id: 2, productId: 1, size: "M", stock: 15),
  DetailProduct(id: 3, productId: 1, size: "L", stock: 8),
  DetailProduct(id: 4, productId: 1, size: "XL", stock: 0),
  DetailProduct(id: 5, productId: 1, size: "XXL", stock: 9),
  // Id 2
  DetailProduct(id: 6, productId: 2, size: "S", stock: 10),
  DetailProduct(id: 7, productId: 2, size: "M", stock: 0),
  DetailProduct(id: 8, productId: 2, size: "L", stock: 8),
  DetailProduct(id: 9, productId: 2, size: "XL", stock: 8),
  DetailProduct(id: 10, productId: 2, size: "XXL", stock: 8),
  // Id 3
  DetailProduct(id: 11, productId: 3, size: "S", stock: 10),
  DetailProduct(id: 12, productId: 3, size: "M", stock: 0),
  DetailProduct(id: 13, productId: 3, size: "L", stock: 8),
  DetailProduct(id: 14, productId: 3, size: "XL", stock: 8),
  DetailProduct(id: 15, productId: 3, size: "XXL", stock: 8),
  // Id 4
  DetailProduct(id: 16, productId: 4, size: "S", stock: 10),
  DetailProduct(id: 17, productId: 4, size: "M", stock: 0),
  DetailProduct(id: 18, productId: 4, size: "L", stock: 8),
  DetailProduct(id: 19, productId: 4, size: "XL", stock: 8),
  DetailProduct(id: 20, productId: 4, size: "XXL", stock: 8),
  // Tambahkan detail produk lain sesuai kebutuhan
];

List<Map<String, dynamic>> getFormattedProducts() {
  return products.map((product) {
    final productDetails = detailProducts
        .where((detail) => detail.productId == product.id)
        .map((detail) => {
              "id": detail.id,
              "productId": detail.productId,
              "size": detail.size,
              "stock": detail.stock,
            })
        .toList();

    return {
      "id": product.id,
      "categoryId": product.categoryId,
      "title": product.title,
      "subtitle": product.subtitle,
      "description": product.description,
      "gender": product.gender,
      "price": product.price,
      "rating": product.rating,
      "image": product.imageUrl,
      "product_details": productDetails,
    };
  }).toList();
}
