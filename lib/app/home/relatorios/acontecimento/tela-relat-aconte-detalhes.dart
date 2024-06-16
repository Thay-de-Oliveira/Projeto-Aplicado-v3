import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';

class DetalhesRelatorioAcontecimento extends StatelessWidget {
  final AcontecimentoModel acontecimento;

  const DetalhesRelatorioAcontecimento({Key? key, required this.acontecimento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 50,
            flexibleSpace: BarraSuperior(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        const BoxShadow(
                          color: Color(0x3F2F2F2F),
                          blurRadius: 1,
                          offset: Offset(1, 1),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dados do acontecimento', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          'assets/imagens/icon-padrao-acontecimento.png', 
                          'Atendimento Realizado:', 
                          (acontecimento.pendente != null && acontecimento.pendente == true) ? 'Não' : 'Sim'
                        ),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Classe:', acontecimento.classe),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Grupo:', acontecimento.grupo),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Subgrupo:', acontecimento.subgrupo),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Tipo:', acontecimento.tipo),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Subtipo:', acontecimento.subtipo),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'COBRADE:', acontecimento.infoCobrade),
                        _buildDetailRow('assets/imagens/icon-data-vistoria.png', 'Data:', DateFormat('dd/MM/yyyy').format(acontecimento.dataHora)),
                        _buildDetailRow('assets/imagens/icon-hora.png', 'Horário aproximado:', DateFormat('HH:mm').format(acontecimento.dataHora)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget _buildDetailRow(String iconPath, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const ShapeDecoration(
              color: Color(0xFFCFDDF2),
              shape: OvalBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(iconPath),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}