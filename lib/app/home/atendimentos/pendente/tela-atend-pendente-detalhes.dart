import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:projetoaplicado/app/home/atendimentos/cadastro/tela-atendimento-forms.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';

class DetalhesAtendimentoPendente extends StatelessWidget {
  final AcontecimentoModel acontecimento;

  const DetalhesAtendimentoPendente({Key? key, required this.acontecimento})
      : super(key: key);

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
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  'Dados do acontecimento',
                  [
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Atendimento Realizado:', (acontecimento.pendente != null && acontecimento.pendente == true) ? 'Não' : 'Sim'),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Protocolo:', acontecimento.numeroProtocolo!),
                    _buildDetailRow('assets/imagens/icon-padrao-acontecimento.png', 'Endereço:', '${acontecimento.rua}, Bairro ${acontecimento.bairro}'),
                    _buildDetailRow('assets/imagens/icon-data-vistoria.png', 'Data:', DateFormat('dd/MM/yyyy').format(acontecimento.dataHora)),
                    _buildDetailRow('assets/imagens/icon-hora.png', 'Horário aproximado:', DateFormat('HH:mm').format(acontecimento.dataHora)),
                  ],
                ),
                _buildActionSection(
                  context,
                  [
                    _buildButton(
                      context,
                      onTap: () {
                        String endereco = '${acontecimento.rua}, ${acontecimento.bairro}, ${acontecimento.cidade} - ${acontecimento.estado}, ${acontecimento.cep}';
                        MapsLauncher.launchQuery(endereco);
                      },
                      iconData: Icons.location_on,
                      text: 'Localização do acontecimento',
                    ),
                    _buildButton(
                      context,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AtendimentoForms(
                              numeroProtocolo: acontecimento.numeroProtocolo,
                            ),
                          ),
                        );
                      },
                      iconData: Icons.arrow_back,
                      text: 'Realizar atendimento',
                    ),
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

  Widget _buildSection(BuildContext context, String sectionTitle, List<Widget> details) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),  // Espaçamento uniforme nas bordas
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

  Widget _buildActionSection(BuildContext context, List<Widget> actions) {
    return Column(
      children: actions,
    );
  }

  Widget _buildButton(BuildContext context, {required VoidCallback onTap, required IconData iconData, required String text}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Icon(iconData, color: Color(0xFF2987C0)),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }
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