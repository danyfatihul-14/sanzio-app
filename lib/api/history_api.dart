import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/models/order.dart';

class HistoryApiHandler {
  final String baseUrl = dotenv.env['API_BASEURL']!;

  Future<void> fetchHistory() async {
    print("Fetching products");
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/orders'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Order> products = data.map((item) => Order.fromJson(item)).toList();

      var box = Hive.box('History');
      box.put(1, products);
    } else {
      print("Gagal");
      throw Exception('Failed to load products');
    }
  }

  Future<List<Order>> getHistory() async {
    await fetchHistory();
    var box = Hive.box('History');
    return box.get(1).cast<Order>();
  }

  Future<Order> createOrder(OrderForm order) async {
    print("Order: $order");
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('$baseUrl/api/orders'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'address_id': order.addressId,
        'order_details': order.detailProducts.map((e) => e.toJson()).toList()
      }),
    );

    if (response.statusCode == 201) {
      dynamic data = json.decode(response.body);
      int orderData = data['order_id'];
      final history = await getHistory();
      final newOrder = history.firstWhere((element) => element.id == orderData,
          orElse: () => throw Exception('Order not found'));

      return newOrder;
    } else {
      print("Gagal");
      throw Exception('Failed to load products');
    }
  }

  Future<bool> FinishOrder(int orderId) async {
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('$baseUrl/api/orders/$orderId/compt'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Gagal");
      return false;
    }
  }

  Future<bool> CancleOrder(int orderId) async {
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('$baseUrl/api/orders/$orderId/cancle'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Gagal");
      return false;
    }
  }
}
