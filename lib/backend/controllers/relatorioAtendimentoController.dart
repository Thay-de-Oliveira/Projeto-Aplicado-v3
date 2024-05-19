import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorio-atend-detalhes.dart';
import 'package:projetoaplicado/backend/services/relatorioAtendimentoService.dart';

class RelatorioAtendimentoController {
  final RelatorioAtendimentoService _relatorioService = RelatorioAtendimentoService();

  Future<void> gerarRelatorio(BuildContext context, String nProtocolo) async {
    try {
      final pdfUrl = await _relatorioService.gerarRelatorio(nProtocolo);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalhesRelatorioAtendimento(pdfUrl: pdfUrl),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar relatório: $e')),
      );
    }
  }

  Future<String> gerarRelatorioUrl(String nProtocolo) async {
    try {
      return await _relatorioService.gerarRelatorio(nProtocolo);
    } catch (e) {
      throw Exception('Erro ao gerar relatório: $e');
    }
  }
}