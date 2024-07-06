import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorio-atend-detalhes.dart';
import 'package:projetoaplicado/app/home/relatorios/recibos/tela-relatorio-recibo-detalhes.dart';
import 'package:projetoaplicado/backend/services/relatorioAtendimentoService.dart';

class RelatorioAtendimentoController extends GetxController {
  final RelatorioAtendimentoService relatorioService;

  RelatorioAtendimentoController({required this.relatorioService});

  Future<void> gerarRelatorio(BuildContext context, String nProtocolo) async {
    try {
      final pdfUrl = await relatorioService.gerarRelatorio(nProtocolo);
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

  Future<void> gerarRelatorioRecibo(BuildContext context, String nProtocolo) async {
    try {
      final pdfReciboUrl = await relatorioService.gerarRelatorioRecibo(nProtocolo);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalhesRelatorioRecibo(pdfReciboUrl: pdfReciboUrl),
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
      return await relatorioService.gerarRelatorio(nProtocolo);
    } catch (e) {
      throw Exception('Erro ao gerar relatório: $e');
    }
  }

  Future<String> gerarRelatorioReciboUrl(String nProtocolo) async {
    try {
      return await relatorioService.gerarRelatorioRecibo(nProtocolo);
    } catch (e) {
      throw Exception('Erro ao gerar relatório: $e');
    }
  }
}