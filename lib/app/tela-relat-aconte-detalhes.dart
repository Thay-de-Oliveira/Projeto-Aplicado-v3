import 'package:flutter/material.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-atend-historico.dart';
import 'tela-atendimento-forms.dart';

class DetalhesRelatorioAcontecimento extends StatefulWidget {
  @override
  _DetalhesRelatorioAcontecimentoState createState() =>
      _DetalhesRelatorioAcontecimentoState();
}

class _DetalhesRelatorioAcontecimentoState
    extends State<DetalhesRelatorioAcontecimento> {
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

                //Card 1
                Center(
                    child: Container(
                  width: 338,
                  height: 451,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 331,
                          height: 16,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 159,
                                  height: 16,
                                  child: Text(
                                    'Dados da acontecimento',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 27,
                        child: Container(
                          width: 338,
                          height: 424,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 338,
                                  height: 424,
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 13,
                                top: 11,
                                child: Container(
                                  width: 320,
                                  height: 395,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: SizedBox(
                                          width: 120,
                                          height: 18,
                                          child: Text(
                                            'Acontecimento',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 4.50,
                                        top: 130.12,
                                        child: Container(
                                          width: 20.62,
                                          height: 20.62,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 34,
                                        child: Container(
                                          width: 199,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 6,
                                                child: SizedBox(
                                                  width: 156,
                                                  height: 15,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Classe:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' Natural',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //CLASSE
                                                left: 5,
                                                top: 25,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-padrao-acontecimento.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 75,
                                        child: Container(
                                          width: 199,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 6,
                                                child: SizedBox(
                                                  width: 156,
                                                  height: 15,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Grupo:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' Meteorológico',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //GRUPO
                                                left: 5,
                                                top: 25,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-padrao-acontecimento.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 116,
                                        child: Container(
                                          width: 212,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 6,
                                                child: SizedBox(
                                                  width: 169,
                                                  height: 15,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Subgrupo:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' Tempestade',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //SUBGRUPO
                                                left: 5,
                                                top: 25,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-padrao-acontecimento.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 157,
                                        child: Container(
                                          width: 265,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 6,
                                                child: SizedBox(
                                                  width: 222,
                                                  height: 15,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Tipo:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' Tempestade local/Convectiva',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //TIPO
                                                left: 5,
                                                top: 25,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-padrao-acontecimento.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 198,
                                        child: Container(
                                          width: 174,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 6,
                                                child: SizedBox(
                                                  width: 131,
                                                  height: 15,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Subtipo: ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'Vendaval',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //SUBTIPO
                                                left: 5,
                                                top: 25,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-padrao-acontecimento.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 239,
                                        child: Container(
                                          width: 174,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 6,
                                                child: SizedBox(
                                                  width: 140,
                                                  height: 15,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'COBRADE: ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: '1.3.2.1.5',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //COBRADE
                                                left: 5,
                                                top: 25,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-1.57),
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-padrao-acontecimento.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 280,
                                        child: Container(
                                          width: 313,
                                          height: 33,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 43,
                                                top: 1,
                                                child: SizedBox(
                                                  width: 270,
                                                  height: 32,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Endereço:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' Rua Severino Jr., 123E - Bairro: Efapi | Chapecó/SC',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //ENDEREÇO
                                                left: 4,
                                                top: 4,
                                                child: Container(
                                                  //Icone
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      'assets/imagens/icon-endereco.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 324,
                                        child: Container(
                                          width: 280,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 43,
                                                top: 7,
                                                child: SizedBox(
                                                  width: 237,
                                                  height: 16,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Data:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' 05/05/2023',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //DATA
                                                left: 6,
                                                top: 6,
                                                child: Container(
                                                  //Icone
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      'assets/imagens/icon-data-vistoria.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 365,
                                        child: Container(
                                          width: 280,
                                          height: 30,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 43,
                                                top: 7,
                                                child: SizedBox(
                                                  width: 237,
                                                  height: 16,
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Horário aproximado:',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' 20:30',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFCFDDF2),
                                                    shape: OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                //DATA
                                                left: 6,
                                                top: 6,
                                                child: Container(
                                                  //Icone
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      'assets/imagens/icon-hora.png'),
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
                                left: 19,
                                top: 383,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(children: []),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                SizedBox(height: 15),

                Container(
                  width: 338,
                  height: 214,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 11,
                        child: Container(
                          width: 331,
                          height: 16,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 130,
                                  height: 16,
                                  child: Text(
                                    'Registro fotográfico',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 30,
                        child: Container(
                          width: 338,
                          height: 182,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 200,
                                  height: 178.43,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/200x178"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 208,
                                top: 0,
                                child: Container(
                                  width: 200,
                                  height: 178,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/200x178"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 416,
                                top: 0,
                                child: Container(
                                  width: 200,
                                  height: 178.27,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/200x178"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 624,
                                top: 0,
                                child: Container(
                                  width: 200,
                                  height: 181.76,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/200x182"),
                                      fit: BoxFit.fill,
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
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
