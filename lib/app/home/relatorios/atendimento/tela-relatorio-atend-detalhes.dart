import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DetalhesRelatorioAtendimento extends StatelessWidget {
  final String pdfUrl;

  DetalhesRelatorioAtendimento({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visualizar PDF')),
      body: PDFView(
        filePath: pdfUrl,
      ),
    );
  }
}