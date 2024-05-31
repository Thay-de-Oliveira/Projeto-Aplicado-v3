import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';

class CidadaoService {
  String baseUrl = "https://web-production-0b75.up.railway.app";

  // Método adaptado para buscar cidadãos por nome ou CPF, parcial ou completo
  Future<List<CidadaoModel>> fetchListCidadao({String? searchTerm}) async {
    final query = searchTerm?.isEmpty ?? true ? '.' : searchTerm;
    final response = await http.get(Uri.parse('$baseUrl/cidadaos/search?query=$query'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      return list.map((item) => CidadaoModel.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar lista de cidadãos');
    }
  }

  // Criar cidadão
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

  // Buscar cidadão por CPF
  Future<CidadaoModel> getCidadaoByCpf(String cpf) async {
    final response = await http.get(Uri.parse('$baseUrl/cidadaos/cpf/$cpf'));

    if (response.statusCode == 200) {
      return CidadaoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao buscar cidadão');
    }
  }

  // Atualizar cidadão por CPF
  Future<CidadaoModel> updateCidadaoByCpf(String cpf, CidadaoModel cidadao) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cidadaos/cpf/$cpf'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(cidadao.toJson()),
    );

    if (response.statusCode == 200) {
      return CidadaoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar cidadão');
    }
  }

  // Deletar cidadão por CPF
  Future<bool> deleteCidadaoByCpf(String cpf) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/cidadaos/cpf/$cpf'));

      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.statusCode == 404) {
          throw Exception('Cidadão não encontrado.');
        } else if (response.statusCode == 403) {
          throw Exception('Acesso negado.');
        } else {
          throw Exception('Erro ao deletar cidadão: ${response.statusCode}');
        }
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }
}
