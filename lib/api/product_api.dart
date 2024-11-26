import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:raffaelosanzio/models/hive/product_hive.dart';

class ProductApiHandler {
  final String baseUrl = dotenv.env['API_BASEURL']!;

  Future<void> fetchAndStoreProducts() async {
    print("Fethcing products");
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> products =
          data.map((item) => Product.fromJson(item)).toList();

      var box = Hive.box('Product');
      box.put(1, products);
      box.put(
          2, DateTime.now().add(Duration(minutes: 2)).millisecondsSinceEpoch);
      print("Fethcing success");
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> getProducts() async {
    var box = Hive.box('Product');
    int? expiryTime = box.get(2);

    if (expiryTime != null &&
        DateTime.now().millisecondsSinceEpoch < expiryTime) {
      return box.get(1).cast<Product>();
    } else {
      await fetchAndStoreProducts();
      return box.get(1).cast<Product>();
    }
  }
}
