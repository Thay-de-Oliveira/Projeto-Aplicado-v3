import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';

class AcontecimentoService {
  String baseUrl = "http://24.144.96.178:3000";

  Future<List<AcontecimentoModel>> fetchListAcontecimento() async {
    final response = await http.get(Uri.parse('$baseUrl/acontecimentos'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<AcontecimentoModel> listAcontecimentoModel = [];
      for (var item in list) {
        listAcontecimentoModel.add(AcontecimentoModel.fromJson(item));
      }

      return listAcontecimentoModel;
    } else {
      throw Exception('Falha ao carregar lista de acontecimentos');
    }
  }

  Future<bool> deleteAcontecimento(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/acontecimentos/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<AcontecimentoModel> editAcontecimento(AcontecimentoModel acontecimento) async {
    final response = await http.put(
      Uri.parse('$baseUrl/acontecimentos/${acontecimento.id}'),
      body: json.encode(acontecimento.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return AcontecimentoModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao editar acontecimento');
    }
  }

  Future<AcontecimentoModel> postAcontecimento(AcontecimentoModel acontecimento) async {
    final response = await http.post(
      Uri.parse('$baseUrl/acontecimentos'),
      body: json.encode(acontecimento.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return AcontecimentoModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao criar acontecimento');
    }
  }
}
