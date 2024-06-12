import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorio-atend-detalhes.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/backend/controllers/relatorioAtendimentoController.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';

class AtendimentoCardRelatorio extends StatelessWidget {
  final AtendimentosModel atendimento;
  final RelatorioAtendimentoController _relatorioController =
      RelatorioAtendimentoController();
  final CidadaoController cidadaoController = Get.put(CidadaoController());

  AtendimentoCardRelatorio({Key? key, required this.atendimento})
      : super(key: key);

  Future<void> _visualizarRelatorio(BuildContext context) async {
    try {
      print('Gerando URL do PDF para o protocolo: ${atendimento.n_protocolo}');
      final pdfUrl =
          await _relatorioController.gerarRelatorioUrl(atendimento.n_protocolo);
      final downloadUrl = _transformUrlToDownloadUrl(pdfUrl);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetalhesRelatorioAtendimento(pdfUrl: downloadUrl),
        ),
      );
    } catch (e) {
      print('Erro ao gerar relatório: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar relatório: $e')),
      );
    }
  }

  String _transformUrlToDownloadUrl(String viewUrl) {
    final fileId = viewUrl.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  }

  Future<CidadaoModel> _fetchCidadao() async {
    await cidadaoController.getCidadaoByCpf(atendimento.cidadaoResponsavel);
    return cidadaoController.listCidadaoObs.first;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _visualizarRelatorio(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        width: 330,
        height: 120,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 330,
                height: 113,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F2F2F2F),
                      blurRadius: 1,
                      offset: Offset(1, 1),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 9,
              top: 15,
              child: SizedBox(
                width: 189,
                height: 21,
                child: Text(
                  atendimento.tipoAtendimento,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 208,
              top: 89,
              child: RealizarAtendimentoButton(
                onTap: () => _visualizarRelatorio(context),
                text:
                    atendimento.pdfUrl != null && atendimento.pdfUrl!.isNotEmpty
                        ? 'Visualizar Relatório'
                        : 'Gerar Relatório',
              ),
            ),
            Positioned(
              left: 9,
              top: 31,
              child: FutureBuilder<CidadaoModel>(
                future: _fetchCidadao(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Erro ao carregar endereço");
                  } else if (!snapshot.hasData) {
                    return Text("Endereço não encontrado");
                  } else {
                    return DataAcontecimentoInfo(
                      dataAcontecimento: atendimento.dataSolicitacao,
                      nProtocolo: atendimento.n_protocolo,
                      endereco:
                          '${snapshot.data!.bairro}, ${snapshot.data!.cidade} - ${snapshot.data!.estado}',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RealizarAtendimentoButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const RealizarAtendimentoButton(
      {Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      height: 17,
      decoration: BoxDecoration(
        color: const Color(0xFFCFDDF2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 115,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DataAcontecimentoInfo extends StatelessWidget {
  final String dataAcontecimento;
  final String nProtocolo;
  final String endereco;

  const DataAcontecimentoInfo({
    Key? key,
    required this.dataAcontecimento,
    required this.nProtocolo,
    required this.endereco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 11),
      width: 251,
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            'N° do protocolo: ' '$nProtocolo',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 4),
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
          const SizedBox(height: 4),
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
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
