import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/home/atendimentos/historico/tela-atend-hist-detalhes.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';

class AtendimentoCard extends StatelessWidget {
  final AtendimentosModel atendimento;
  final CidadaoController cidadaoController = Get.put(CidadaoController());

  AtendimentoCard({Key? key, required this.atendimento}) : super(key: key);

  Future<CidadaoModel> _fetchCidadao() async {
    await cidadaoController.getCidadaoByCpf(atendimento.nomeResponsavel);
    return cidadaoController.listCidadaoObs.first;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a tela de detalhes ao clicar no card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheHistorico(atendimento: atendimento),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 11),
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
              child: RealizarAtendimentoButton(),
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

class TempoIcone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23,
      height: 9,
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icon-card-tempo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            '10d',
            style: TextStyle(
              color: Color(0xFF082778),
              fontSize: 8,
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

class ComentariosIcone extends StatelessWidget {
  final int comentarios;

  const ComentariosIcone({Key? key, required this.comentarios})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 9,
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imagens/icon-card-comentario.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$comentarios',
            style: const TextStyle(
              color: Color(0xFF082778),
              fontSize: 8,
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

class VencimentoIcone extends StatelessWidget {
  final String vencimento;

  const VencimentoIcone({Key? key, required this.vencimento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77,
      height: 8,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imagens/icon-card-vencimento.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'Venc.: $vencimento',
            style: const TextStyle(
              color: Color(0xFF082778),
              fontSize: 8,
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

class RealizarAtendimentoButton extends StatelessWidget {
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
        child: Container(
          width: 115,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              'Visualizar Atendimento',
              style: TextStyle(
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
