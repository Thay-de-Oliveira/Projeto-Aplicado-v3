import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/tela-relatorios-acontecimento.dart';
import 'package:projetoaplicado/app/tela-relatorios-atendimento.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-relat-aconte-detalhes.dart';

class RelatorioRecibo extends StatefulWidget {
  @override
  _RelatorioReciboState createState() => _RelatorioReciboState();
}

class _RelatorioReciboState extends State<RelatorioRecibo> {
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

                SizedBox(height: 25),

                //Barra de pesquisa + filtro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Botão FILTRO
                    InkWell(
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
                    ),

                    // Espaçamento entre a barra de pesquisa e o botão de filtro
                    SizedBox(width: 10),

                    //Barra de pesquisa
                    Container(
                      width: 253,
                      height: 32,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 253,
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
                                            140.0), //Espaçamento à direita do texto
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

                //Card 1
                Center(
                    child: Container(
                  width: 330,
                  height: 127,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 330,
                          height: 127,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F2F2F2F),
                                blurRadius: 1,
                                offset: Offset(1, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9,
                        top: 14,
                        child: SizedBox(
                          width: 189,
                          height: 21,
                          child: Text(
                            'Tempestade - Vendaval',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 261,
                        top: 103,
                        child: Container(
                          width: 63,
                          height: 17,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 63,
                                  height: 17,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFCFDDF2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetalhesRelatorioAcontecimento()), //MUDAR PARA PDF
                                  );
                                },
                                child: Positioned(
                                  left: 10,
                                  top: 7,
                                  child: Container(
                                    width: 57,
                                    height: 15,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 10,
                                          top: 8,
                                          child: SizedBox(
                                            width: 50,
                                            height: 11,
                                            child: Text(
                                              'Relatório',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: Stack(children: []),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9,
                        top: 31,
                        child: Container(
                          width: 251,
                          height: 72,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 20,
                                top: 20,
                                child: SizedBox(
                                  width: 199,
                                  height: 14,
                                  child: Text(
                                    'Data do acontecimento: 05/05/2023',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 39,
                                child: SizedBox(
                                  width: 214,
                                  height: 14,
                                  child: Text(
                                    'Bairro: Efapi | Cidade: Chapecó/SC',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 58,
                                child: SizedBox(
                                  width: 120,
                                  height: 14,
                                  child: Text(
                                    'COBRADE: 1.3.2.1.5',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 20,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFCFDDF2),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 3,
                                        top: 3,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
                                          child: Stack(children: []),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 0,
                                child: SizedBox(
                                  width: 231,
                                  height: 14,
                                  child: Text(
                                    'N° do protocolo de acontecimento: 0002',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFCFDDF2),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 39,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFCFDDF2),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 58,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFCFDDF2),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 114,
                        child: Container(
                          width: 108,
                          height: 8,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 11,
                                top: 0,
                                child: SizedBox(
                                  width: 97,
                                  height: 8,
                                  child: Text(
                                    '09/05/2023', //pegar data do banco de dados
                                    style: TextStyle(
                                      color: Color(0xFF082778),
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
