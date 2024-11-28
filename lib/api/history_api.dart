import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

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
}
