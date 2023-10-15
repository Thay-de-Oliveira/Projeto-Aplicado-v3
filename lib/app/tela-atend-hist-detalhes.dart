import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-atendimento-forms.dart';
import 'tela-atend-historico.dart';

class DetalheHistorico extends StatefulWidget {
  State<DetalheHistorico> createState() => _DetalheHistorico();
}

class _DetalheHistorico extends State<DetalheHistorico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: BarraSuperior(context),
          ),
          Positioned(
            left: 11,
            top: 70,
            child: Container(
              width: 338,
              height: 88,
              child: Stack(
                children: [
                  Container(
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
                                  top: 30,
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
                                                      BorderRadius.circular(3)),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 7,
                                          top: -8,
                                          child: Container(
                                            //Icone
                                            width: 30,
                                            height: 30,
                                            child: Image.asset(
                                                'assets/imagens/icon-donwload.png'),
                                          ),
                                        ),
                                        Positioned(
                                          left: 31,
                                          top: 8,
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
                                  top: 12,
                                  child: SizedBox(
                                    width: 45,
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
                                  top: 30,
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
                                                      BorderRadius.circular(3)),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 7,
                                          top: -8,
                                          child: Container(
                                            //Icone
                                            width: 30,
                                            height: 30,
                                            child: Image.asset(
                                                'assets/imagens/icon-donwload.png'),
                                          ),
                                        ),
                                        Positioned(
                                          left: 31,
                                          top: 8,
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
                                  top: 12,
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
                        SizedBox(height: 10),
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
                                  top: 12,
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
                                  top: 30,
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
                                                      BorderRadius.circular(3)),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 7,
                                          top: -8,
                                          child: Container(
                                            //Icone
                                            width: 30,
                                            height: 30,
                                            child: Image.asset(
                                                'assets/imagens/icon-donwload.png'),
                                          ),
                                        ),
                                        Positioned(
                                          left: 31,
                                          top: 8,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
