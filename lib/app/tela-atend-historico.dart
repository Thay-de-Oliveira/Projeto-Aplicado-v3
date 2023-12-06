import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/atendimento-card.dart';
import 'package:projetoaplicado/app/tela-atend-hist-detalhes.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-atendimento-forms.dart';


class HistoricoAtendimento extends StatefulWidget {
  @override
  _HistoricoAtendimentoState createState() => _HistoricoAtendimentoState();
}

class _HistoricoAtendimentoState extends State<HistoricoAtendimento> {
  final AtendimentoController atendimentoController = Get.put(AtendimentoController());

  @override
  void initState() {
    super.initState();
    _loadAtendimentos();
  }

  void _loadAtendimentos() async {
    await atendimentoController.listAtendimento();
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
                      child: buildMenuButton(
                        'Cadastro',
                        'assets/imagens/icon-cadastro-inativo.png',
                        AtendimentoForms(),
                      ),
                    ),
                    GestureDetector(
                      child: buildMenuButton(
                        'Pendente',
                        'assets/imagens/icon-pendente.png',
                        AtendimentoPendente(),
                      ),
                    ),
                    //Botão Historico
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
                                    builder: (context) => HistoricoAtendimento()));
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
                                      'assets/imagens/icon-historico-ativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Histórico',
                                  style: TextStyle(
                                    fontSize: 16,
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
                SizedBox(height: 25),
                buildSearchBar(),
                SizedBox(height: 25),

                // Lista de Cards de Atendimento
                Center(
                  child: Container(
                    width: 330,  // Largura desejada dos cards
                    child: Obx(
                      () {
                        // Verifica se a lista está vazia e se o círculo de carregamento está visível
                        if (atendimentoController.isLoading.value) {
                          Future.delayed(Duration(seconds: 1), () {
                            // A cada 1 segundo, verifica se a lista foi carregada
                            if (atendimentoController.listAtendimentoObs.isNotEmpty) {
                              atendimentoController.isLoading.value = false; // Oculta o círculo de carregamento
                            }
                          });
                          return Center(child: CircularProgressIndicator());
                        } else {
                          var atendimentosPendentes = atendimentoController.listAtendimentoObs
                              .where((atendimento) => atendimento.pendente)
                              .toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: atendimentosPendentes.length,
                            itemBuilder: (context, index) {
                              return AtendimentoCard(atendimento: atendimentosPendentes[index]);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                // Fim da Lista de Cards
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

    Widget buildMenuButton(String text, String imagePath, Widget destination) {
    return Ink(
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
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
                child: Image.asset(imagePath),
              ),
              SizedBox(height: 5.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 220.0),
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
    );
  }
}
