import 'package:flutter/material.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/app/home/cidadaos/historico/tela-detalhes-cidadao.dart';

class CidadaoCard extends StatelessWidget {
  final CidadaoModel cidadao;

  const CidadaoCard({Key? key, required this.cidadao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Direcionar para a tela de detalhes do cidadão
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesCidadao(),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  'Cidadão: ${cidadao.name}',
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
                  'CPF: ${cidadao.cpf}',
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
                  'Endereço: ${cidadao.rua}, Bairro ${cidadao.bairro}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 12), // Aumenta o espaçamento entre o texto e o botão
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
                      onTap: () {
                        // Implementar ação de informações
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesCidadao(),
                          ),
                        );
                      },
                      child: Container(
                        width: 115,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Informações',
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
