import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/app/home/atendimentos/cadastro/tela-atendimento-forms.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relat-aconte-detalhes.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';

class AcontecimentoCardRelatorio extends StatelessWidget {
  final AcontecimentoModel acontecimento;

  const AcontecimentoCardRelatorio({Key? key, required this.acontecimento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesRelatorioAcontecimento(
              acontecimento: acontecimento,
            ),
          ),
        );
      },
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
                width: 250,
                height: 21,
                child: Text(
                  acontecimento.subgrupo,
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
              left: 9,
              top: 31,
              child: DataHoraInfo(
                dataHora: acontecimento.dataHora,
                numeroProtocolo: acontecimento.numeroProtocolo ?? "Sem Protocolo",
                rua: acontecimento.rua,
                bairro: acontecimento.bairro,
              ),
            ),
            Positioned(
              left: 188,
              top: 89,
              child: VisualizarAcontecimentoButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class VisualizarAcontecimentoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 17,
      decoration: BoxDecoration(
        color: const Color(0xFFCFDDF2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        child: Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              'Visualizar Acontecimento',
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

class DataHoraInfo extends StatelessWidget {
  final DateTime dataHora;
  final String numeroProtocolo;
  final String rua;
  final String bairro;

  const DataHoraInfo({
    Key? key,
    required this.dataHora,
    required this.numeroProtocolo,
    required this.rua,
    required this.bairro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      width: 251,
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            'N° do protocolo: ' '$numeroProtocolo',
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
            'Endereço: ''$rua' ', Bairro ''$bairro',
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
            'Data do acontecimento: ${DateFormat('dd/MM/yyyy').format(dataHora)}',
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