import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:http_parser/http_parser.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

class UserApiHandler {
  final String baseUrl = dotenv.env['API_BASEURL']!;

  Future<void> fetchUser() async {
    print("Fetching User");
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/user/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User user = User.fromJson(data);
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
    return box.get(1);
  }

  Future<bool> updateUserPicture(File file) async {
    if (file.lengthSync() == 0) {
      print("File is empty!");
      return false;
    }

    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/api/user/image'),
    );

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType:
          MediaType('image', 'jpeg'), // Adjust the content type as needed
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Foto Profil Berhasil Diperbarui");
      return true;
    } else {
      print("Terjadi Kesalahan Saat Memperbarui Foto Profil");
      return false;
    }
  }

  Future<bool> updateUserDetails(String username, String fullname, String email,
      String noTelp, String? gender) async {
    print("Gender: ${User.stringToGender(gender)}");
    final genderConvert = User.stringToGender(gender);
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.put(
      Uri.parse('$baseUrl/api/user/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'fullname': fullname,
        'email': email,
        'no_telpon': noTelp,
        'gender': genderConvert.toString().split('.').last,
      }),
    );
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Failed to load user details");
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    await AuthHandler().validateToken();
    final storage = StorageService().storage;
    final accessToken = await storage.read(key: 'access_token');
    final response = await http.put(
      Uri.parse('$baseUrl/api/user/password'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'old_password': oldPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      print("Password berhasil diubah");
      return true;
    } else {
      print("Gagal mengubah password");
      return false;
    }
  }
}
