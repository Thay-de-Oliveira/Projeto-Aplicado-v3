import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/globais/filtro-atendimento.dart';
import 'package:projetoaplicado/app/components/recibo/recibo-card-relatorio.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relatorios-acontecimento.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorios-atendimento.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa-e-filtro.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';

class RelatorioRecibo extends StatefulWidget {
  @override
  _RelatorioReciboState createState() => _RelatorioReciboState();
}

class _RelatorioReciboState extends State<RelatorioRecibo> {
  final AtendimentoController atendimentoController = Get.put(AtendimentoController());

  @override
  void initState() {
    super.initState();
    _loadRecibos();
  }

  Future<void> _loadRecibos() async {
    await atendimentoController.listAtendimento();
    atendimentoController.listAtendimentoObs;
  }

  // void _onSearch(String query) {
  //   atendimentoController.searchByWord(query);
  // }

  // void _showFilterDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return FiltroAtendimento(
  //         subgrupos: atendimentoController.listAtendimentoObs.map((a) => a.tipoAtendimento).toSet().toList(),
  //         tiposAtendimento: atendimentoController.listAtendimentoObs.map((a) => a.tipoAtendimento).toSet().toList(),
  //         // onSave: (filters) {
  //         //   atendimentoController.filterAtendimentoHistorico(filters);
  //         // },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,  // Adicionado para remover o botão de voltar preto
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Botão ACONTECIMENTO
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 2,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RelatorioAcontecimento()));
                          },
                          child: Container(
                            width: 110,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-acontecimento-inativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Acontecimento',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Botão ATENDIMENTO
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 2,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RelatorioAtendimento()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-atendimento-inativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Atendimento',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Botão RECIBOS
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xFFBBD8F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 2,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RelatorioRecibo()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-recibos-ativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Recibos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // SearchFilterBar(
                //   onSearch: _onSearch,
                //   onFilter: _showFilterDialog,
                // ),
                SizedBox(height: 25),
                  // Lista de Cards de Atendimento
                Center(
                  child: Container(
                    width: 330,
                    child: FutureBuilder(
                      future: atendimentoController.listAtendimento(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Erro ao carregar atendimentos'),
                              );
                            } else {
                              // Filtrar os recibos
                              var AtendimentosComItensEntregues = atendimentoController.listAtendimentoObs
                                  .where((atendimento) => atendimento.entregueItensAjuda == true)
                                  .toList();

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: AtendimentosComItensEntregues.length,
                                itemBuilder: (context, index) {
                                  AtendimentosModel atendimento = AtendimentosComItensEntregues[index];
                                  return Column(
                                    children: [
                                      ReciboCardRelatorio(atendimento: atendimento),
                                      SizedBox(height: 12), // Espaçamento entre os cards
                                    ],
                                  );
                                },
                              );
                            }
                          default:
                            return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
