import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/components/globais/barra-superior.dart';
import 'package:projetoaplicado/app/components/globais/menu-inferior.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';

class DetalhesCidadao extends StatelessWidget {
  final CidadaoModel? cidadao;

  DetalhesCidadao({this.cidadao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 50,
            flexibleSpace: BarraSuperior(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: _buildSection(
                          context,
                          'Dados do cidadão',
                          [
                            _buildInfoRow(
                                'assets/imagens/icon-nome-solicitante.png',
                                'Nome do solicitante:',
                                cidadao?.name ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-cpf.png',
                                'CPF do solicitante:',
                                cidadao?.cpf ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-rg.png',
                                'RG do solicitante:',
                                cidadao?.rg ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-telefone.png',
                                'Telefone do solicitante:',
                                cidadao?.telefone ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'Número de pessoas no imóvel:',
                                cidadao?.numPessoasNaCasa.toString() ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'CEP:',
                                cidadao?.cep ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'Rua:',
                                cidadao?.rua ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'Bairro:',
                                cidadao?.bairro ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'Cidade:',
                                cidadao?.cidade ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'Estado:',
                                cidadao?.estado ?? '',
                                const Color(0xFFF08D86)),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                                'assets/imagens/icon-pessoas-imovel.png',
                                'Número da casa:',
                                cidadao?.numeroCasa.toString() ?? '',
                                const Color(0xFFF08D86)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String iconPath, String label, String value, Color color) {
    return Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Container(
              width: 18,
              height: 18,
              child: Image.asset(iconPath),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '$label ',
              style: TextStyle(fontWeight: FontWeight.normal),
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}