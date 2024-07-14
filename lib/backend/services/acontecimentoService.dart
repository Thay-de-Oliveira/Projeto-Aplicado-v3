import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';

class AcontecimentoService {
  final String baseUrl;
  final http.Client client;

  AcontecimentoService(this.client, {this.baseUrl = "http://15.228.187.56:3000"});

  Future<List<AcontecimentoModel>> fetchListAcontecimento() async {
    final response = await client.get(Uri.parse('$baseUrl/acontecimentos'));

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

  Future<AcontecimentoModel> fetchAcontecimentoByProtocolo(String numeroProtocolo) async {
    final response = await client.get(Uri.parse('$baseUrl/acontecimentos/protocolo/$numeroProtocolo'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      if (list != null && list.isNotEmpty) {
        return AcontecimentoModel.fromJson(list);
      } else {
        throw Exception('Nenhum acontecimento encontrado');
      }
    } else {
      throw Exception('Falha ao carregar acontecimento');
    }
  }

  Future<bool> deleteAcontecimento(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/acontecimentos/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<AcontecimentoModel> editAcontecimento(AcontecimentoModel acontecimento) async {
    final response = await client.put(
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
    final response = await client.post(
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

  // Método para pesquisa avançada
  Future<List<AcontecimentoModel>> searchAcontecimentos({
    required String term,
    String? dataInicio,
    String? dataFim,
    int limit = 10,
    int page = 1,
  }) async {
    String url = '$baseUrl/acontecimentos/search?term=$term&limit=$limit&page=$page';

    if (dataInicio != null && dataInicio.isNotEmpty) {
      url += '&dataInicio=$dataInicio';
    }

    if (dataFim != null && dataFim.isNotEmpty) {
      url += '&dataFim=$dataFim';
    }

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<AcontecimentoModel> listAcontecimentoModel = [];
      for (var item in list['data']) {
        listAcontecimentoModel.add(AcontecimentoModel.fromJson(item));
      }
      return listAcontecimentoModel;
    } else {
      throw Exception('Falha ao carregar lista de acontecimentos');
    }
  }
}