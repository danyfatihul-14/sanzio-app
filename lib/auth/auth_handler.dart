import 'dart:async';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthHandler {
  final String baseUrl = dotenv.env['API_BASEURL']!;

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 202) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['access_token'];
      final refreshToken = responseData['refresh_token'];

      // Save tokens securely
      // You can use flutter_secure_storage or any other secure storage package
      final storage = StorageService().storage;
      await storage.write(key: 'access_token', value: accessToken);
      await storage.write(key: 'refresh_token', value: refreshToken);
      return true;
    } else {
      // Handle login failure
      print('Login failed: ${response.body}');
      return false;
    }
  }

  Future<bool> register(
      String username, String fullname, String email, String password) async {
    print("regist on going");
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "fullname": fullname,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      // Handle successful registration
      print('Registration successful');
      return true;
    } else {
      // Handle registration failure
      print('Registration failed: ${response.body}');
      return false;
    }
  }

  Future<bool> logout() async {
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      print('No tokens found');
      return false;
    }

    final url = Uri.parse('$baseUrl/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Cookie': 'refresh_token=$refreshToken',
      },
    );

    if (response.statusCode == 200) {
      // Clear tokens from storage
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');
      var userBox = await Hive.box('User');
      var historyBox = await Hive.box('History');
      var cartBox = await Hive.box('Cart');
      var skinBox = await Hive.box('SkinType');
      if (cartBox.isNotEmpty) {
        await cartBox.clear();
      }
      // Clear data from Hive boxes
      await userBox.clear();
      await historyBox.clear();
      if (skinBox.isNotEmpty) {
        await skinBox.clear();
      }
      print('Logout successful');
      return true;
    } else {
      print('Logout failed: ${response.body}');
      return false;
    }
  }

  Future<bool> validateToken() async {
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      print('No tokens found');
      return false;
    }

    try {
      // Dapatkan tanggal kadaluarsa dari JWT
      final DateTime expirationDate = JwtDecoder.getExpirationDate(accessToken);

      // Validasi apakah token masih berlaku
      if (expirationDate.isAfter(DateTime.now())) {
        print('Token is valid');
        return true;
      } else {
        print('Token has expired, attempting to refresh');
        return await _refreshToken();
      }
    } catch (e) {
      // Menangani kesalahan parsing JWT
      print('Token validation failed: $e');
      return false;
    }
  }

  Future<bool> _refreshToken() async {
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      print('No tokens found');
      return false;
    }
    try {
      final DateTime expirationDate =
          JwtDecoder.getExpirationDate(refreshToken);

      if (expirationDate.isAfter(DateTime.now())) {
        print('Token is valid');
        final url = Uri.parse('$baseUrl/api/refresh');
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refresh_token=$refreshToken'
          },
          body: jsonEncode({
            'refresh_token': refreshToken,
          }),
        );

        if (response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          final newAccessToken = responseData['access_token'];

          final storage = StorageService().storage;
          await storage.write(key: 'access_token', value: newAccessToken);

          print('Token refreshed successfully');
          return true;
        } else {
          print('Token refresh failed: ${response.body}');
          return false;
        }
      } else {
        print('Token has expired, attempting to refresh');
        return false;
      }
    } catch (e) {
      print('Token validation failed: $e');
      return false;
    }
  }
}

class StorageService {
  static final StorageService _instance = StorageService._internal();
  late FlutterSecureStorage storage;

  factory StorageService() {
    return _instance;
  }

  StorageService._internal() {
    storage = FlutterSecureStorage();
  }
}
