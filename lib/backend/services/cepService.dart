import 'dart:convert';
import 'package:http/http.dart' as http;

class CepService {
  Future<Map<String, dynamic>?> buscarCep(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('erro') && data['erro'] == true) {
        return null;
      }
      return data;
    } else {
      return null;
    }
  }
}