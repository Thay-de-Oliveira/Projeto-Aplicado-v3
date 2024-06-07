import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/usuarioModel.dart';

class UserService {
  String baseUrl = "https://web-production-0b75.up.railway.app/auth";

  Future<UserModel?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: json.encode({
        'email': email,
        'password': password,
      }),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      return null;
    }
  }
}
