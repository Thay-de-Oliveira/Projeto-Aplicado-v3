import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/home/relatorios/recibos/tela-relatorio-recibo-detalhes.dart';
import 'package:projetoaplicado/backend/controllers/relatorioAtendimentoController.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';

class ReciboCardRelatorio extends StatefulWidget {
  final AtendimentosModel atendimento;

  ReciboCardRelatorio({Key? key, required this.atendimento})
      : super(key: key);

  @override
  _ReciboCardRelatorioState createState() => _ReciboCardRelatorioState();
}

class _ReciboCardRelatorioState extends State<ReciboCardRelatorio> {
  final RelatorioAtendimentoController _relatorioController = Get.find<RelatorioAtendimentoController>();
  bool _isGeneratingReport = false;

  Future<void> _visualizarRelatorio(BuildContext context) async {
    setState(() {
      _isGeneratingReport = true;
    });

    try {
      final pdfReciboUrl = await _relatorioController.gerarRelatorioReciboUrl(widget.atendimento.nProtocolo);
      final downloadUrl = _transformUrlToDownloadUrl(pdfReciboUrl);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetalhesRelatorioRecibo(pdfReciboUrl: downloadUrl),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar relatório: $e')),
      );
    } finally {
      setState(() {
        _isGeneratingReport = false;
      });
    }
  }

  String _transformUrlToDownloadUrl(String viewUrl) {
    final fileId = viewUrl.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _visualizarRelatorio(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 03),
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(62, 133, 133, 133),
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.atendimento.tipoAtendimento,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 8),
                DataAcontecimentoInfo(
                  dataAcontecimento: widget.atendimento.dataSolicitacao,
                  nProtocolo: widget.atendimento.nProtocolo,
                  endereco: '${widget.atendimento.rua}, Bairro ${widget.atendimento.bairro}',
                  atendente: widget.atendimento.atendenteResponsavel,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 116,
                    height: 35,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFDDF2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: InkWell(
                      onTap: () => _visualizarRelatorio(context),
                      child: Container(
                        width: 115,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            widget.atendimento.pdfReciboUrl != null && widget.atendimento.pdfReciboUrl!.isNotEmpty
                                ? 'Visualizar Relatório'
                                : 'Gerar Relatório',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_isGeneratingReport)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text('Gerando relatório...'),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DataAcontecimentoInfo extends StatelessWidget {
  final String dataAcontecimento;
  final String nProtocolo;
  final String endereco;
  final String atendente;

  const DataAcontecimentoInfo({
    Key? key,
    required this.dataAcontecimento,
    required this.nProtocolo,
    required this.endereco,
    required this.atendente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            'N° do protocolo: $nProtocolo',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Data do acontecimento: $dataAcontecimento',
            style: TextStyle(
              color: Colors.black.withOpacity(0.85),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Endereço: $endereco',
            style: TextStyle(
              color: Colors.black.withOpacity(0.85),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Atendente: $atendente',
            style: TextStyle(
              color: Colors.black.withOpacity(0.85),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
