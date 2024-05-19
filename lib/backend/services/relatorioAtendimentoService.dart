import 'dart:convert';
import 'package:http/http.dart' as http;

class RelatorioAtendimentoService {
  //String baseUrl = "https://web-production-0b75.up.railway.app"; // Substitua pelo URL do seu servidor
  String baseUrl = "https://web-production-0b75.up.railway.app/relatorios"; // Substitua pelo URL do seu servidor

  // Gerar relatorio de atendimento
  Future<String> gerarRelatorio(String nProtocolo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/gerar-relatorio-atendimento'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'n_protocolo': nProtocolo}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['url'];
    } else {
      throw Exception('Erro ao gerar relatório');
    }
  }
}