import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorios-atendimento.dart';
import 'package:projetoaplicado/app/home/relatorios/recibos/tela-relatorios-recibo.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/acontecimento/acontecimento-card-relatorio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';

import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa.dart'; 

class RelatorioAcontecimento extends StatefulWidget {
  @override
  _RelatorioAcontecimentoState createState() => _RelatorioAcontecimentoState();
}

class _RelatorioAcontecimentoState extends State<RelatorioAcontecimento> {
  final AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());

  Future<void> _loadAcontecimentos() async {
    await acontecimentoController.listAcontecimento();
    acontecimentoController.listAcontecimentoObs;
  }

  @override
  void initState() {
    super.initState();
    _loadAcontecimentos();
  }

  void _onSearch(String query) {
    acontecimentoController.searchByWord(query);
  }

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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Color(0xFFBBD8F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
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
                                    builder: (context) => RelatorioAcontecimento()));
                          },
                          child: Container(
                            width: 110,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('assets/imagens/icon-acontecimento-ativo.png'),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Acontecimento',
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
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
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
                                    builder: (context) => RelatorioAtendimento()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('assets/imagens/icon-atendimento-inativo.png'),
                                ),
                                SizedBox(height: 5.0),
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
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
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
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('assets/imagens/icon-recibos-inativo.png'),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Recibos',
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
                  ],
                ),
                SizedBox(height: 25),
                SearchFilterBar(
                  onSearch: _onSearch,
                ),
                SizedBox(height: 25),
                Center(
                  child: Container(
                    width: 330,
                    child: Obx(() {
                      if (acontecimentoController.isLoading.value) {
                        Future.delayed(Duration(seconds: 1), () {
                          if (acontecimentoController.listAcontecimentoObs.isNotEmpty) {
                            acontecimentoController.isLoading.value = false;
                          }
                        });
                        return Center(child: CircularProgressIndicator());
                      } else {
                        var acontecimentos = acontecimentoController.listAcontecimentoObs
                            .where((acontecimento) => acontecimento.pendente ?? false)
                            .toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: acontecimentos.length,
                          itemBuilder: (context, index) {
                            return AcontecimentoCardRelatorio(acontecimento: acontecimentos[index]);
                          },
                        );
                      }
                    }),
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
