import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfPath; // Caminho do PDF local ou URL

  PdfViewerScreen({required this.pdfPath});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: widget.pdfPath,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        nightMode: false,
        onRender: (pages) {
          // Executa quando o PDF é renderizado
          print("PDF is rendered");
        },
        onViewCreated: (PDFViewController pdfViewController) {
          // Configura o controlador do PDF
          _pdfViewController = pdfViewController;
        },
        onPageChanged: (int? page, int? total) {
          // Executa quando a página é alterada
          print("Page changed: $page/$total");
        },
      ),
    );
  }
}
