import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';

class AtendimentoService {
  final String baseUrl;
  final http.Client client;

  AtendimentoService(this.client, {this.baseUrl = "https://web-production-0b75.up.railway.app/atendimentos"});

  Future<List<AtendimentosModel>> fetchListAtendimento() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

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
    final response = await client.get(Uri.parse('$baseUrl/atendimento/$id'));

    if (response.statusCode == 200) {
      var atendimento = json.decode(response.body);
      return AtendimentosModel.fromJson(atendimento);
    } else {
      throw Exception('Falha ao obter atendimento por ID');
    }
  }

  Future<bool> deleteAtendimento(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<AtendimentosModel> editAtendimento(AtendimentosModel atendimento) async {
    final response = await client.put(
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

  Future<String> postAtendimento(AtendimentosModel atendimento, List<File> imageFiles) async {
    var uri = Uri.parse('$baseUrl/cria_atendimento');
    var request = http.MultipartRequest('POST', uri);

    // Adiciona os campos do formulário
    Map<String, dynamic> atendimentoData = atendimento.toJson();
    atendimentoData.forEach((key, value) {
      if (value is List) {
        request.fields[key] = jsonEncode(value);
      } else {
        request.fields[key] = value.toString();
      }
    });

    // Adiciona cada arquivo de imagem à requisição
    for (var file in imageFiles) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      var multipartFile = http.MultipartFile(
        'Files',
        stream,
        length,
        filename: basename(file.path),
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(multipartFile);
    }

    try {
      // Use o CustomHttpClient para enviar a requisição
      var response = await client.send(request);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        return responseBody;
      } else {
        String responseBody = await response.stream.bytesToString();
        throw Exception('Falha ao criar atendimento: $responseBody');
      }
    } catch (e) {
      throw Exception('Erro ao enviar dados: $e');
    }
  }

  Future<List<AtendimentosModel>> searchAtendimentos({
    String? term,
    String? dataInicio,
    String? dataFim,
    bool? entregueItensAjuda,
    int limit = 10,
    int page = 1,
  }) async {
    var queryParams = {
      'term': term,
      'dataInicio': dataInicio,
      'dataFim': dataFim,
      'limit': limit.toString(),
      'page': page.toString(),
    };

    if (entregueItensAjuda != null) {
      queryParams['entregueItensAjuda'] = entregueItensAjuda.toString();
    }

    queryParams.removeWhere((key, value) => value == null || value.isEmpty);

    final uri = Uri.parse('$baseUrl/search').replace(queryParameters: queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      var list = json.decode(response.body)['data'];
      List<AtendimentosModel> listAtendimentoModel = [];
      for (var item in list) {
        listAtendimentoModel.add(AtendimentosModel.fromJson(item));
      }

      return listAtendimentoModel;
    } else {
      throw Exception('Falha ao buscar atendimentos');
    }
  }
}