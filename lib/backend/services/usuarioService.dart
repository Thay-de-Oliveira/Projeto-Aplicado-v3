import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:projetoaplicado/app/login/tela-login.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';

class UserService {
  late http.Client client;
  final storage = FlutterSecureStorage();
  final String baseUrl = "https://web-production-0b75.up.railway.app/auth";

  UserService(this.client);

  void setClient(http.Client newClient) {
    client = newClient;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      await storage.write(key: 'accessToken', value: data['accessToken']);
      await storage.write(key: 'refreshToken', value: data['refreshToken']);
      await storage.write(key: 'user', value: json.encode(data['user']));
      return UserModel.fromJson(data['user']);
    } else {
      print('Login failed with status: ${response.statusCode}');
      return null;
    }
  }

  Future<void> logoutUser() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    await storage.delete(key: 'user');
    Get.offAll(() => LoginApp());
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await storage.read(key: 'refreshToken');
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/refresh-token'),
        body: json.encode({'refreshToken': refreshToken}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(key: 'accessToken', value: data['accessToken']);
      } else {
        var errorData = json.decode(response.body);
        throw Exception('Failed to refresh access token: ${errorData['message']}');
      }
    } catch (e) {
      throw Exception('Failed to refresh access token: $e');
    }
  }

  Future<UserModel?> getUserFromStorage() async {
    String? userData = await storage.read(key: 'user');
    if (userData != null) {
      return UserModel.fromJson(json.decode(userData));
    }
    return null;
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  Future<DateTime?> getExpiryDate() async {
    String? token = await getAccessToken();
    if (token != null) {
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
        if (payload['exp'] != null) {
          return DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        }
      }
    }
    return null;
  }
}