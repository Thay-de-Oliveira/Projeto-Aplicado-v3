import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

// Barra Superior Customizada
Widget BarraSuperior(BuildContext context, VoidCallback onDownloadPressed, VoidCallback onSharePressed) {
  bool isHome = ModalRoute.of(context)?.isFirst ?? false;

  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return SafeArea(
        child: Container(
          width: double.infinity,
          height: 57,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: constraints.maxWidth,
                  height: 57,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(1.00, -0.03),
                      end: Alignment(-1, 0.03),
                      colors: [Color(0xFF1A7CB2), Color(0xFF4BA1E0)],
                    ),
                  ),
                ),
              ),
              if (!isHome)
                Positioned(
                  left: 8,
                  top: 8,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              Positioned(
                left: (constraints.maxWidth / 2) - 22.5,
                top: 8,
                child: Container(
                  width: 45,
                  height: 42.49,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/imagens/logo-sem-fundo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 60,
                top: 8,
                child: IconButton(
                  icon: Icon(Icons.file_download, color: Colors.white),
                  onPressed: onDownloadPressed,
                ),
              ),
              Positioned(
                right: 16,
                top: 8,
                child: IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: onSharePressed,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

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
      final file = await _downloadFile(widget.pdfUrl, 'relatorio_atendimento.pdf');
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
      final filePath = '${directory?.path}/relatorio_atendimento.pdf';
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
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: BarraSuperior(
          context,
          _downloadToDevice,
          _sharePdf,
        ),
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