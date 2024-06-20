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
                _buildSection(
                  context,
                  'Informações do Atendimento',
                  [
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Atendimento Realizado:', (acontecimento.pendente != null && acontecimento.pendente == true) ? 'Não' : 'Sim'),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Protocolo:', acontecimento.numeroProtocolo!),
                    _buildDetailRow('assets/imagens/icon-data-vistoria.png', 'Data:', DateFormat('dd/MM/yyyy').format(acontecimento.dataHora)),
                    _buildDetailRow('assets/imagens/icon-hora.png', 'Horário aproximado:', DateFormat('HH:mm').format(acontecimento.dataHora)),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Cidadão solicitante:', acontecimento.cidadaoResponsavel),
                  ],
                ),
                _buildSection(
                  context,
                  'Endereço do Acontecimento',
                  [
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Cep:', acontecimento.cep),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Endereço:', '${acontecimento.rua}, Bairro ${acontecimento.bairro}'),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Cidade:', acontecimento.cidade),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Estado:', acontecimento.estado),
                  ],
                ),
                _buildSection(
                  context,
                  'Dados Adicionais',
                  [
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Classe:', acontecimento.classe),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Grupo:', acontecimento.grupo),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Subgrupo:', acontecimento.subgrupo),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Tipo:', acontecimento.tipo),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Subtipo:', acontecimento.subtipo),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'COBRADE:', acontecimento.infoCobrade!),
                  ],
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

  Widget _buildSection(BuildContext context, String sectionTitle, List<Widget> details) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),  // Adicionado espaçamento uniforme
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...details,
        ],
      ),
    );
  }
}