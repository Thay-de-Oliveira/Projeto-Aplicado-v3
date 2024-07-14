import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/app/home/atendimentos/pendente/tela-atend-pendente-detalhes.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';

class AcontecimentoCard extends StatelessWidget {
  final AcontecimentoModel acontecimento;

  const AcontecimentoCard({Key? key, required this.acontecimento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a tela de detalhes de atendimento pendente com o acontecimento
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesAtendimentoPendente(
              acontecimento: acontecimento,
            ),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.only(bottom: 11),
            padding: EdgeInsets.all(8),
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(62, 133, 133, 133),
                  blurRadius: 2, // Aumenta a área de desfoque da sombra
                  offset: Offset(2, 2), // Ajusta a posição da sombra
                  spreadRadius: 2, // Aumenta a área de propagação da sombra
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  acontecimento.subgrupo,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 4),
                DataHoraInfo(
                  dataHora: acontecimento.dataHora,
                  numeroProtocolo: acontecimento.numeroProtocolo ?? "Sem Protocolo",
                  rua: acontecimento.rua,
                  bairro: acontecimento.bairro,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RealizarAtendimentoButton(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RealizarAtendimentoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 35,
      decoration: BoxDecoration(
        color: const Color(0xFFCFDDF2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        child: Container(
          width: 135,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              'Realizar Atendimento',
              style: TextStyle(
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
    );
  }
}

class DataHoraInfo extends StatelessWidget {
  final String dataHora;
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
          const SizedBox(height: 8),
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
          const SizedBox(height: 8),
          Text(
            'Data do acontecimento: $dataHora',
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
