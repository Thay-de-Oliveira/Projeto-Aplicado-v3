import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class DetalhesRelatorioAtendimento extends StatefulWidget {
  final String pdfUrl;

  DetalhesRelatorioAtendimento({required this.pdfUrl});

  @override
  _DetalhesRelatorioAtendimentoState createState() => _DetalhesRelatorioAtendimentoState();
}

class _DetalhesRelatorioAtendimentoState extends State<DetalhesRelatorioAtendimento> {
  bool _isLoading = true;
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      print('Iniciando download do PDF da URL: ${widget.pdfUrl}');
      final file = await _downloadFile(widget.pdfUrl, 'relatorio.pdf');
      setState(() {
        _localFilePath = file.path;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar PDF: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<File> _downloadFile(String url, String filename) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$filename';
    print('Salvando PDF em: $filePath');
    final dio = Dio();
    await dio.download(url, filePath);
    return File(filePath);
  }

  @override
  void dispose() {
    super.dispose();
    if (_localFilePath != null) {
      final file = File(_localFilePath!);
      if (file.existsSync()) {
        print('Removendo PDF do cache: ${file.path}');
        file.deleteSync();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visualizar Relatório')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _localFilePath != null
              ? PDFView(
                  filePath: _localFilePath!,
                )
              : Center(child: Text('Falha ao carregar PDF')),
    );
  }
}