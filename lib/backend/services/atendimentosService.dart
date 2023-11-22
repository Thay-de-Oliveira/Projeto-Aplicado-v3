import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/atendimentosModel.dart';

class AtendimentosService {
  String baseUrl = "http://24.144.96.178:3000";

  Future<List<atendimentosModel>> fetchListAtendimento() async {
    final response = await http.get(Uri.parse('$baseUrl/atendimentos'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<atendimentosModel> listatendimentosModel = [];
      for (var item in list) {
        listatendimentosModel.add(atendimentosModel.fromJson(item));
      }

      return listatendimentosModel;
    } else {
      throw Exception('Falha ao carregar lista de atendimentos');
    }
  }

  Future<bool> deleteAtendimento(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/atendimentos/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<atendimentosModel> editAtendimento(atendimentosModel atendimento) async {
    final response = await http.put(
      Uri.parse('$baseUrl/atendimentos/${atendimento.id}'),
      body: json.encode(atendimento.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return atendimentosModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao editar atendimento');
    }
  }

  Future<atendimentosModel> postAtendimento(atendimentosModel atendimento) async {
    final response = await http.post(
      Uri.parse('$baseUrl/atendimentos'),
      body: json.encode(atendimento.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return atendimentosModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao criar atendimento');
    }
  }
}
