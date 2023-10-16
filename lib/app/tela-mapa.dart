import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';
import 'tela-login.dart';
import 'tela-inicio.dart';
import 'tela-usuario.dart';

class Mapa extends StatefulWidget {
  State<Mapa> createState() => _MapaState(); //Função
}

class _MapaState extends State<Mapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, //Permite a visualização da barra superior
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            //Permite descer na tela
            child: Container(
              width: 360,
              height: 1510,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 11,
                    top: 191,
                    child: Container(
                      width: 338,
                      height: 866,
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
                                      width: 130,
                                      height: 16,
                                      child: Text(
                                        'Dados da ocorrência',
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
                              height: 839,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 338,
                                      height: 839,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    left: 56,
                                    top: 238,
                                    child: SizedBox(
                                      width: 143,
                                      height: 16,
                                      child: Text(
                                        'N° do protocolo: 0002',
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
                                  Positioned(
                                    left: 13,
                                    top: 231,
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
                                    left: 13,
                                    top: 15,
                                    child: Container(
                                      width: 313,
                                      height: 240,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: SizedBox(
                                              width: 100,
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
                                            left: 0,
                                            top: 30,
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
                                            top: 36,
                                            child: SizedBox(
                                              width: 156,
                                              height: 15,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Subgrupo:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' Tempestades.',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            left: 43,
                                            top: 83,
                                            child: SizedBox(
                                              width: 226,
                                              height: 16,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Tipo:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' Tempestade local/Convectiva.',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            top: 76,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFCFDDF2),
                                                        shape: OvalBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 25,
                                                    top: 5,
                                                    child: Transform(
                                                      transform:
                                                          Matrix4.identity()
                                                            ..translate(
                                                                0.0, 0.0)
                                                            ..rotateZ(1.57),
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                "https://via.placeholder.com/20x20"),
                                                            fit: BoxFit.fill,
                                                          ),
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
                                            top: 122,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFCFDDF2),
                                                        shape: OvalBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 4.50,
                                                    top: 4.12,
                                                    child: Container(
                                                      width: 20.62,
                                                      height: 20.62,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child:
                                                          Stack(children: []),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 43,
                                            top: 122,
                                            child: SizedBox(
                                              width: 270,
                                              height: 31,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Evento:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' Tempestade local com vendaval de alta intensidade.',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            left: 43,
                                            top: 176,
                                            child: SizedBox(
                                              width: 130,
                                              height: 16,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'COBRADE:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' 1.3.2.1.5',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            top: 169,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFCFDDF2),
                                                        shape: OvalBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 5,
                                                    top: 5,
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://via.placeholder.com/20x20"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            top: 55,
                                            child: Transform(
                                              transform: Matrix4.identity()
                                                ..translate(0.0, 0.0)
                                                ..rotateZ(-1.57),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://via.placeholder.com/20x20"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 6,
                                            top: 222,
                                            child: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/18x18"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 570,
                                    child: Container(
                                      width: 313,
                                      height: 249,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: SizedBox(
                                              width: 84,
                                              height: 15,
                                              child: Text(
                                                'Atendimento',
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
                                            left: 0,
                                            top: 216,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF8BD69C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 42,
                                            top: 177,
                                            child: SizedBox(
                                              width: 244,
                                              height: 15,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Ocorrência: ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'Destelhamento do imóvel.',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            left: 43,
                                            top: 217,
                                            child: SizedBox(
                                              width: 270,
                                              height: 32,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Endereço da ocorrência:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' Av. São Pedro, 123E - Bairro: Efapi | Chapecó/SC',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            top: 170,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF8BD69C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 43,
                                            top: 39,
                                            child: SizedBox(
                                              width: 220,
                                              height: 16,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Nome do atendente:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' Paulo da Silva',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            top: 32,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF8BD69C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 43,
                                            top: 85,
                                            child: SizedBox(
                                              width: 196,
                                              height: 16,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Código de identificação:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' 1255',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            top: 78,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF8BD69C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            top: 83,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/20x20"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 43,
                                            top: 131,
                                            child: SizedBox(
                                              width: 214,
                                              height: 16,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Data da vistoria:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' 08/05/2023',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
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
                                            top: 124,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF8BD69C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 6,
                                            top: 130,
                                            child: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/18x18"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 7,
                                            top: 38,
                                            child: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/18x18"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 7,
                                            top: 177,
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/16x16"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 8,
                                            top: 220,
                                            child: Container(
                                              width: 14,
                                              height: 20.36,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/14x20"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 292,
                                    child: Container(
                                      width: 290,
                                      height: 244,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: SizedBox(
                                              width: 111,
                                              height: 15,
                                              child: Text(
                                                'Família/Cidadãos',
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
                                            left: 0,
                                            top: 30,
                                            child: Container(
                                              width: 290,
                                              height: 214,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 43,
                                                    top: 53,
                                                    child: SizedBox(
                                                      width: 229,
                                                      height: 16,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'CPF do solicitante:',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' 123456789-10',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                    top: 46,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                              width: 30,
                                                              height: 30,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: Color(
                                                                    0xFFF08C86),
                                                                shape:
                                                                    OvalBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 5,
                                                            top: 5,
                                                            child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child:
                                                                        Container(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage("https://via.placeholder.com/20x20"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left: 3,
                                                                    top: 10,
                                                                    child:
                                                                        Container(
                                                                      width: 14,
                                                                      height: 5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: Color(0xFFF08C86)),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left: 6,
                                                                    top: 10,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 8,
                                                                      height: 5,
                                                                      child:
                                                                          Text(
                                                                        'CPF',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              4,
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height:
                                                                              0,
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
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 43,
                                                    top: 145,
                                                    child: SizedBox(
                                                      width: 247,
                                                      height: 16,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Telefone do solicitante:',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' 49 98888-0888',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                    top: 138,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                              width: 30,
                                                              height: 30,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: Color(
                                                                    0xFFF08C86),
                                                                shape:
                                                                    OvalBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 7,
                                                            top: 5,
                                                            child: Container(
                                                              width: 17,
                                                              height: 20.92,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "https://via.placeholder.com/17x21"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 43,
                                                    top: 191,
                                                    child: SizedBox(
                                                      width: 214,
                                                      height: 18,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Número de pessoas no imóvel:',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: ' 03',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                    top: 184,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFF08C86),
                                                        shape: OvalBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 43,
                                                    top: 7,
                                                    child: SizedBox(
                                                      width: 223,
                                                      height: 16,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Nome do solicitante:',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' Lucas da Silva',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                              width: 30,
                                                              height: 30,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: Color(
                                                                    0xFFF08C86),
                                                                shape:
                                                                    OvalBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 5,
                                                            top: 5,
                                                            child: Container(
                                                              width: 19,
                                                              height: 19,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "https://via.placeholder.com/19x19"),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 43,
                                                    top: 96,
                                                    child: SizedBox(
                                                      width: 229,
                                                      height: 16,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'RG do solicitante:',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' 01234567891',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                                                    top: 92,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                              width: 30,
                                                              height: 30,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: Color(
                                                                    0xFFF08C86),
                                                                shape:
                                                                    OvalBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 5,
                                                            top: 5,
                                                            child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child:
                                                                        Container(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage("https://via.placeholder.com/20x20"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left: 3,
                                                                    top: 10,
                                                                    child:
                                                                        Container(
                                                                      width: 14,
                                                                      height: 5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: Color(0xFFF08C86)),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left: 7,
                                                                    top: 10,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 6,
                                                                      height: 5,
                                                                      child:
                                                                          Text(
                                                                        'RG',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              4,
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height:
                                                                              0,
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
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 6,
                                                    top: 190,
                                                    child: Container(
                                                      width: 18,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://via.placeholder.com/18x18"),
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
                    left: 11,
                    top: 73,
                    child: Container(
                      width: 338,
                      height: 88,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 232,
                            top: 25,
                            child: Container(
                              width: 106,
                              height: 63,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 106,
                                      height: 63,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                                    left: 10,
                                    top: 24,
                                    child: SizedBox(
                                      width: 86,
                                      height: 9,
                                      child: Text(
                                        'Emitido em 09/05/2023',
                                        style: TextStyle(
                                          color: Color(0xFF6C6C6C),
                                          fontSize: 8,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 41,
                                    child: Container(
                                      width: 86,
                                      height: 16,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 86,
                                              height: 16,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF7CA0FF),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 15,
                                            top: 4,
                                            child: Container(
                                              width: 9,
                                              height: 9,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/9x9"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 27,
                                            top: 3,
                                            child: SizedBox(
                                              width: 41,
                                              height: 10,
                                              child: Text(
                                                'Donwload',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                  fontFamily: 'Lato',
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
                                  Positioned(
                                    left: 36,
                                    top: 5,
                                    child: SizedBox(
                                      width: 34,
                                      height: 12,
                                      child: Text(
                                        'Recibo',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
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
                            left: 116,
                            top: 25,
                            child: Container(
                              width: 106,
                              height: 63,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 106,
                                      height: 63,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                                    left: 10,
                                    top: 24,
                                    child: SizedBox(
                                      width: 86,
                                      height: 9,
                                      child: Text(
                                        'Emitido em 09/05/2023',
                                        style: TextStyle(
                                          color: Color(0xFF6C6C6C),
                                          fontSize: 8,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 41,
                                    child: Container(
                                      width: 86,
                                      height: 16,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 86,
                                              height: 16,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF7CA0FF),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 15,
                                            top: 4,
                                            child: Container(
                                              width: 9,
                                              height: 9,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/9x9"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 27,
                                            top: 3,
                                            child: SizedBox(
                                              width: 41,
                                              height: 10,
                                              child: Text(
                                                'Donwload',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                  fontFamily: 'Lato',
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
                                  Positioned(
                                    left: 31,
                                    top: 5,
                                    child: SizedBox(
                                      width: 45,
                                      height: 12,
                                      child: Text(
                                        'Relatório',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
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
                            top: 0,
                            child: SizedBox(
                              width: 80,
                              height: 16,
                              child: Text(
                                'Documentos',
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
                          Positioned(
                            left: 0,
                            top: 25,
                            child: Container(
                              width: 106,
                              height: 63,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 106,
                                      height: 63,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                                    left: 26,
                                    top: 5,
                                    child: SizedBox(
                                      width: 54,
                                      height: 12,
                                      child: Text(
                                        'Ocorrência',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 24,
                                    child: SizedBox(
                                      width: 86,
                                      height: 9,
                                      child: Text(
                                        'Emitido em 09/05/2023',
                                        style: TextStyle(
                                          color: Color(0xFF6C6C6C),
                                          fontSize: 8,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 41,
                                    child: Container(
                                      width: 86,
                                      height: 16,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 86,
                                              height: 16,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF7CA0FF),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 15,
                                            top: 4,
                                            child: Container(
                                              width: 9,
                                              height: 9,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://via.placeholder.com/9x9"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 27,
                                            top: 3,
                                            child: SizedBox(
                                              width: 41,
                                              height: 10,
                                              child: Text(
                                                'Donwload',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                  fontFamily: 'Lato',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.99,
                    top: 496,
                    child: Container(
                      width: 338.02,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 11,
                    top: 772,
                    child: Container(
                      width: 338.02,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 11,
                    top: 1087,
                    child: Container(
                      width: 338,
                      height: 214,
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
                            left: 0,
                            top: 32,
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
                    ),
                  ),
                  Positioned(
                    left: 11,
                    top: 1331,
                    child: Container(
                      width: 338,
                      height: 94,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 331,
                              height: 16.08,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: 130,
                                      height: 16,
                                      child: Text(
                                        'Assinaturas',
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
                            top: 31,
                            child: Container(
                              width: 165,
                              height: 63,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 165,
                                      height: 63,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                                    left: 15,
                                    top: 44,
                                    child: Container(
                                      width: 136,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.50,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF999999),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 32,
                                    top: 47,
                                    child: SizedBox(
                                      width: 101,
                                      height: 10,
                                      child: Text(
                                        'Agente da Defesa Civil',
                                        style: TextStyle(
                                          color: Color(0xFF696262),
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
                          Positioned(
                            left: 173,
                            top: 31,
                            child: Container(
                              width: 165,
                              height: 63,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 165,
                                      height: 63,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                                    left: 15,
                                    top: 44,
                                    child: Container(
                                      width: 136,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.50,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF999999),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 56,
                                    top: 47,
                                    child: SizedBox(
                                      width: 53,
                                      height: 10,
                                      child: Text(
                                        'Beneficiado',
                                        style: TextStyle(
                                          color: Color(0xFF696262),
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
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 729,
                    child: Container(
                      width: 360,
                      height: 72,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 360,
                              height: 72,
                              decoration: BoxDecoration(color: Colors.white),
                            ),
                          ),
                          Positioned(
                            left: 271,
                            top: 13,
                            child: Container(
                              width: 39,
                              height: 48,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 3,
                                    top: 36,
                                    child: SizedBox(
                                      width: 33,
                                      height: 12,
                                      child: Text(
                                        'Mapa',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: -0.30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 39,
                                      height: 33,
                                      child: Stack(children: []),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 161,
                            top: 9,
                            child: Container(
                              width: 39,
                              height: 51,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 3,
                                    top: 39,
                                    child: SizedBox(
                                      width: 32,
                                      height: 12,
                                      child: Text(
                                        'Início',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: -0.30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 39,
                                      height: 36,
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
                            left: 47,
                            top: 10,
                            child: Container(
                              width: 43,
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 37,
                                    child: SizedBox(
                                      width: 43,
                                      height: 13,
                                      child: Text(
                                        'Usuário',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: -0.30,
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
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 360,
                      height: 57,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 360,
                              height: 57,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 360,
                                      height: 57,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(1.00, -0.03),
                                          end: Alignment(-1, 0.03),
                                          colors: [
                                            Color(0xFF1A7CB2),
                                            Color(0xFF4BA1E0)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 283,
                                    top: 18,
                                    child: Container(
                                      width: 20,
                                      height: 20,
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
                            left: 158,
                            top: 8,
                            child: Container(
                              width: 45,
                              height: 42.49,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/45x42"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 315,
                            top: 18.27,
                            child: Container(
                              width: 20,
                              height: 20.30,
                              child: Stack(children: []),
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
            //Adiciona e fixa a BarraSuperior
            left: 0,
            top: 0,
            right: 0, // 0 para ocupar toda a largura da página
            child: BarraSuperior(context),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
