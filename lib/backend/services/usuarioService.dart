import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/usuarioModel.dart';

class UserService {
  String baseUrl = "http://127.0.0.1:3000/auth";

  Future<void> registerUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: json.encode({
        'username': user.username,
        'email': user.email,
        'password': user.password,
      }),
      headers: {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 201) {
      print("Usuário registrado com sucesso");
    } else {
      print("Falha ao registrar usuário: ${response.statusCode}");
      throw Exception('Falha ao registrar usuário');
    }
  }

  Future<bool> loginUser(String email, String password) async {
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
      return true; // Login bem-sucedido
    } else {
      return false; // Login falhou
    }
  }
}
