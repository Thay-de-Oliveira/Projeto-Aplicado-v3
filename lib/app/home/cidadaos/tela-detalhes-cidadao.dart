import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/components/globais/barra-superior.dart';
import 'package:projetoaplicado/app/components/globais/menu-inferior.dart';

class DetalhesCidadao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Dados do Cidadão',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            InfoRow(
                              label: 'Nome do solicitante:',
                              value: 'Lucas da Silva',
                              iconPath: 'assets/imagens/icon-nome-solicitante.png',
                            ),
                            InfoRow(
                              label: 'CPF do solicitante:',
                              value: '123456789-10',
                              iconPath: 'assets/imagens/icon-cpf.png',
                            ),
                            InfoRow(
                              label: 'RG do solicitante:',
                              value: '01234567891',
                              iconPath: 'assets/imagens/icon-rg.png',
                            ),
                            InfoRow(
                              label: 'Telefone do solicitante:',
                              value: '49 98888-0888',
                              iconPath: 'assets/imagens/icon-telefone.png',
                            ),
                            InfoRow(
                              label: 'Número de pessoas no imóvel:',
                              value: '03',
                              iconPath: 'assets/imagens/icon-pessoas-imovel.png',
                            ),
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
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;

  InfoRow({required this.label, required this.value, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                child: Image.asset(iconPath),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label ',
                style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetalhesCidadao(),
  ));
}
