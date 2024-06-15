import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';

class DetalhesRelatorioAcontecimento extends StatefulWidget {
  @override
  _DetalhesRelatorioAcontecimentoState createState() => _DetalhesRelatorioAcontecimentoState();
}

class _DetalhesRelatorioAcontecimentoState extends State<DetalhesRelatorioAcontecimento> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        // Permite rolagem da página
        slivers: <Widget>[
          SliverAppBar(
            floating: true, // A barra irá flutuar no topo
            pinned: true, // A barra será fixa no topo
            snap: false, // Não encolherá a barra ao rolar para baixo
            expandedHeight: 50, // Aumente este valor para adicionar mais espaço
            flexibleSpace: BarraSuperior(context), // Barra
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                // Card 1
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
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
                        Text('Dados do acontecimento', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
                        SizedBox(height: 16),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Classe:', 'Natural'),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Grupo:', 'Meteorológico'),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Subgrupo:', 'Tempestade'),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Tipo:', 'Tempestade local/Convectiva'),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Subtipo:', 'Vendaval'),
                        _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'COBRADE:', '1.3.2.1.5'),
                        _buildDetailRow('assets/imagens/icon-endereco.png', 'Endereço:', 'R. Frei Bruno, 201 - Jardim America | Chapecó/SC'),
                        _buildDetailRow('assets/imagens/icon-data-vistoria.png', 'Data:', '05/05/2023'),
                        _buildDetailRow('assets/imagens/icon-hora.png', 'Horário aproximado:', '20:30'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
            decoration: ShapeDecoration(
              color: Color(0xFFCFDDF2),
              shape: OvalBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(iconPath),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
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
