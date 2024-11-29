import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

class AddressApiHandler {
  final String baseUrl = dotenv.env['API_BASEURL']!;

  Future<void> fetchAddress() async {
    print("Fetching Address");
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/address/all'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Address> products =
          data.map((item) => Address.fromJson(item)).toList();

      var box = Hive.box('Address');
      box.put(1, products);
    } else {
      print("Gagal");
      throw Exception('Failed to load products');
    }
  }

  Future<List<Address>> getAddress() async {
    await fetchAddress();
    var box = Hive.box('Address');
    return box.get(1).cast<Address>();
  }

  Future<bool> updateAddress(String address, int index) async {
    var box = Hive.box('Address');
    List<Address> _addresses = box.get(1)?.cast<Address>() ?? [];

    if (_addresses.isNotEmpty && index - 1 < _addresses.length) {
      print("Checkpoin 1");
      await AuthHandler().validateToken();
      final storage = StorageService().storage;
      final accessToken = await storage.read(key: 'access_token');
      print("Checkpoin 2");
      final response = await http.put(
        Uri.parse('$baseUrl/api/address/$index'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'address': address,
          'is_default': _addresses[index - 1].isDefault,
        }),
      );
      print("Checkpoin 3");

      print("Response Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal");
        return false;
      }
    }

    return false;
  }

  Future<bool> mainAddress(int index) async {
    var box = Hive.box('Address');
    List<Address> _addresses = box.get(1)?.cast<Address>() ?? [];

    if (_addresses.isNotEmpty && index - 1 < _addresses.length) {
      print("Checkpoin 1");
      await AuthHandler().validateToken();
      final storage = StorageService().storage;
      final accessToken = await storage.read(key: 'access_token');
      print("Checkpoin 2");
      final response = await http.put(
        Uri.parse('$baseUrl/api/address/$index'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'address': _addresses[index - 1].address,
          'is_default': !_addresses[index - 1].isDefault,
        }),
      );
      print("Checkpoin 3");

      print("Response Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal");
        return false;
      }
    }

    return false;
  }

  Future<bool> createAddress(String address) async {
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    print("Checkpoin 2");
    final response = await http.post(
      Uri.parse('$baseUrl/api/address'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'address': address,
      }),
    );
    print("Checkpoin 3");

    print("Response Code: ${response.statusCode}");
    if (response.statusCode == 201) {
      return true;
    } else {
      print("Gagal");
      return false;
    }
  }

  Future<bool> deleteAddress(int index) async {
    print("Checkpoin 1");
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    print("Checkpoin 2");
    final response = await http.delete(
      Uri.parse('$baseUrl/api/address/$index'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print("Checkpoin 3");

    print("Response Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Gagal");
      return false;
    }
  }
}
