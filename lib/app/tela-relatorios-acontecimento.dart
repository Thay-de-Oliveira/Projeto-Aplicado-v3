import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/tela-relatorios-atendimento.dart';
import 'package:projetoaplicado/app/tela-relatorios-recibo.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/acontecimento/acontecimento-card-relatorio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';

import 'components/globais/barra-superior.dart';
import 'components/globais/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-relat-aconte-detalhes.dart';

class RelatorioAcontecimento extends StatefulWidget {
  @override
  _RelatorioAcontecimentoState createState() => _RelatorioAcontecimentoState();
  
}

class _RelatorioAcontecimentoState extends State<RelatorioAcontecimento> {
    final AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());

// Adicione um tipo de retorno Future<List<AcontecimentoModel>> ao método
  Future<void> _loadAcontecimentos() async {
  await acontecimentoController.listAcontecimento();
  acontecimentoController.listAcontecimentoObs;
}

// Modifique o initState para utilizar o FutureBuilder para lidar com o carregamento
@override
void initState() {
  super.initState();
  _loadAcontecimentos();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        //Permite rolagem da página
        slivers: <Widget>[
          SliverAppBar(
            floating: true, // A barra irá flutuar no topo
            pinned: true, // A barra será fixa no topo
            snap: false, // Não encolherá a barra ao rolar para baixo
            expandedHeight: 50, // Aumente este valor para adicionar mais espaço
            //backgroundColor: Color(0xfff8f7f7),
            flexibleSpace: BarraSuperior(context), //Barra
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
                                      'assets/imagens/icon-acontecimento-ativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
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
                                      'assets/imagens/icon-recibos-inativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
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

                //Barra de pesquisa
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Botão FILTRO
                    /*InkWell(
                      onTap: () {
                        // Ação a ser executada quando o botão de filtro for pressionado
                      },
                      child: Container(
                        width: 65,
                        height: 32,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 65,
                                height: 32,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFCFDDF2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x269FE3FF),
                                      blurRadius: 8,
                                      offset: Offset(1, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6.09,
                              top: 7,
                              child: Container(
                                width: 53.91,
                                height: 18,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.filter_list,
                                      color: Color(0xff121212),
                                      size: 16,
                                    ),
                                    SizedBox(
                                        width:
                                            4), // Espaço entre o ícone e o texto
                                    Text(
                                      'Filtrar',
                                      style: TextStyle(
                                        color: Color(0xFF2F2F2F),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),*/

                    //Barra de pesquisa
                    Container(
                      width: 330,
                      height: 32,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 330,
                              height: 32,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x199FE3FF),
                                    blurRadius: 8,
                                    offset: Offset(1, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 227,
                            top: 8,
                            child: Container(
                              width: 15.37,
                              height: 16,
                              child: Stack(children: []),
                            ),
                          ),
                          Positioned(
                            left: 14,
                            top: 0,
                            child: Container(
                              height: 32,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                        220.0), //Espaçamento à direita do texto
                                    child: Text(
                                      'Pesquisar',
                                      style: TextStyle(
                                        color: Color(0xFF979797),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Color(0xFF979797),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: 25),

                 // Lista de Cards de Acontecimento
                Center(
                  child: Container(
                    width: 330,  // Largura desejada dos cards
                    // Lista de Cards de Atendimento
                    child: Obx(
                      () {
                        if (acontecimentoController.isLoading.value) {
                         Future.delayed(Duration(seconds: 1), () {
                            // A cada 1 segundo, verifica se a lista foi carregada
                            if (acontecimentoController.listAcontecimentoObs.isNotEmpty) {
                              acontecimentoController.isLoading.value = false; // Oculta o círculo de carregamento
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
                              return AcontecimentoCard(acontecimento: acontecimentos[index]);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                // Fim da Lista de Cards),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
