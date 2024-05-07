import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';

class CidadaoService {
  String baseUrl = "https://web-production-0b75.up.railway.app";

  Future<List<CidadaoModel>> find(String search) async {
    if (search.isEmpty) {
      search = '.'; // Se a pesquisa estiver vazia, substitua por "."
    }

    final response = await http.get(Uri.parse('$baseUrl/cidadaos?q=$search'));

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

  Future<List<CidadaoModel>> fetchListCidadao({String? searchTerm}) async {
    // Adicione o parâmetro de pesquisa à URL da solicitação, se houver um termo de pesquisa
    final response = await http.get(Uri.parse('$baseUrl/cidadaos?q=$searchTerm'));

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
