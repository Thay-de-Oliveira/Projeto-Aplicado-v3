import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';


class AtendimentoService {
  // String baseUrl = "http://127.0.0.1:3000/atendimentos";
  String baseUrl = "http://localhost:3000/atendimentos";

  Future<List<AtendimentosModel>> fetchListAtendimento() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        var list = json.decode(response.body);
        List<AtendimentosModel> listAtendimentoModel = [];
        for (var item in list) {
          listAtendimentoModel.add(AtendimentosModel.fromJson(item));
        }

        return listAtendimentoModel;
      } else {
        throw Exception('Falha ao carregar lista de atendimentos');
      }
    } catch (e) {
      throw Exception('Erro durante a solicitação HTTP');
    }
  }

  Future<AtendimentosModel> getAtendimentoById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/atendimento/$id'));

    if (response.statusCode == 200) {
      var atendimento = json.decode(response.body);
      return AtendimentosModel.fromJson(atendimento);
    } else {
      throw Exception('Falha ao obter atendimento por ID');
    }
  }

  Future<bool> deleteAtendimento(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<AtendimentosModel> editAtendimento(AtendimentosModel atendimento) async {
    final response = await http.put(
      Uri.parse('$baseUrl/atualiza_atendimento/${atendimento.id}'),
      body: json.encode(atendimento.toJson()),
      headers: {
        "Accept": "*/*",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return AtendimentosModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao editar atendimento');
    }
  }

  Future<String> postAtendimento(AtendimentosModel atendimento) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cria_atendimento'),
      body: json.encode(atendimento.toJson()),
      headers: {
        "Accept": "*/*",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      String retorno = response.body;
      return retorno;
    } else {
      throw Exception('Falha ao criar atendimento');
    }
  }
}