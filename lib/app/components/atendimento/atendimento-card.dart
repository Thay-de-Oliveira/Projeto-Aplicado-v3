import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/home/atendimentos/historico/tela-atend-hist-detalhes.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';

class AtendimentoCard extends StatelessWidget {
  final AtendimentosModel atendimento;

  AtendimentoCard({Key? key, required this.atendimento}) : super(key: key);

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 03),
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8), // Ajuste aqui o padding superior para aumentar o espaçamento
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
                  'Atendimento: ${atendimento.tipoAtendimento}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'N° do protocolo: ${atendimento.nProtocolo}',
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
                  'Data do atendimento: ${atendimento.dataSolicitacao}',
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
                  'Endereço: ${atendimento.rua}, Bairro ${atendimento.bairro}',
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
                  'Atendente: ${atendimento.atendenteResponsavel}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 10), // Aumenta o espaçamento entre o texto e o botão
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 136,
                    height: 35,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFDDF2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Implementar ação de visualização do atendimento
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalheHistorico(atendimento: atendimento),
                          ),
                        );
                      },
                      child: Container(
                        width: 135,
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
            'Data do atendimento: $dataAcontecimento',
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
