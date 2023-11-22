import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';

class CidadaoService {
  String baseUrl = "http://24.144.96.178:3000";

  Future<List<CidadaoModel>> fetchListCidadao() async {
    final response = await http.get(Uri.parse('$baseUrl/cidadaos'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<CidadaoModel> listCidadaoModel = [];
      for (var item in list) {
        listCidadaoModel.add(CidadaoModel.fromJson(item));
      }

      return listCidadaoModel;
    } else {
      throw Exception('Falha ao carregar lista de cidadãos');
    }
  }

  Future<bool> deleteCidadao(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/cidadaos/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<CidadaoModel> editCidadao(CidadaoModel cidadao) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cidadaos/${cidadao.id}'),
      body: json.encode(cidadao.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return CidadaoModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao editar cidadão');
    }
  }

  Future<CidadaoModel> postCidadao(CidadaoModel cidadao) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cidadaos'),
      body: json.encode(cidadao.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> retorno = json.decode(response.body);
      return CidadaoModel.fromJson(retorno);
    } else {
      throw Exception('Falha ao criar cidadão');
    }
  }
}
