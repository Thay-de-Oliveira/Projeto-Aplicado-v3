import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relat-aconte-detalhes.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';

class AcontecimentoCard extends StatelessWidget {
  final AcontecimentoModel acontecimento;

  const AcontecimentoCard({Key? key, required this.acontecimento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a tela de formulário de atendimento com o protocolo
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesRelatorioAcontecimento(),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth * 0.9;
          return Container(
            margin: const EdgeInsets.only(bottom: 11),
            width: width,
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: width,
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
                const SizedBox(width: 4),
                Positioned(
                  left: 9,
                  top: 15,
                  child: SizedBox(
                    width: width * 0.8,
                    height: 21,
                    child: Text(
                      acontecimento.tipo,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
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
                    width: width * 0.8,
                  ),
                ),
                // Adicione outros elementos conforme necessário
              ],
            ),
          );
        },
      ),
    );
  }
}

class DataHoraInfo extends StatelessWidget {
  final DateTime dataHora;
  final String numeroProtocolo;
  final double width;

  const DataHoraInfo({
    Key? key,
    required this.dataHora,
    required this.numeroProtocolo,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      width: width,
      height: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            'Data e Hora: ${DateFormat.yMd().add_jm().format(dataHora)}',
            style: TextStyle(
              color: Colors.black.withOpacity(0.85),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Número do Protocolo:',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$numeroProtocolo',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
