import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

class UserApiHandler {
  final String baseUrl = dotenv.env['API_BASEURL']!;

  Future<void> fetchUser() async {
    print("Fetching User");
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User user = User.fromJson(data);
      print("User: ${user.image}");
      var box = Hive.box('User');
      box.put(1, user);
      print("Berhasil");
    } else {
      print("Gagal");
      throw Exception('Failed to load products');
    }
  }

  Future<User> getUser() async {
    await fetchUser();
    var box = Hive.box('User');
    return box.get(1).cast<User>();
  }
}
