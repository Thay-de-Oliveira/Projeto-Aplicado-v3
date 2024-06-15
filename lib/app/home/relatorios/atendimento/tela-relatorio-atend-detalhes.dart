import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
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
    final dio = Dio();
    await dio.download(url, filePath);
    return File(filePath);
  }

  Future<void> _downloadToDevice() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory?.path}/relatorio.pdf';
      final file = File(_localFilePath!);
      final newFile = await file.copy(filePath!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF baixado em: ${newFile.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissão de armazenamento negada')),
      );
    }
  }

  Future<void> _sharePdf() async {
    if (_localFilePath != null) {
      await Share.shareFiles([_localFilePath!], text: 'Confira este relatório!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao compartilhar PDF')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_localFilePath != null) {
      final file = File(_localFilePath!);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Relatório'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _downloadToDevice,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _sharePdf,
          ),
        ],
      ),
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