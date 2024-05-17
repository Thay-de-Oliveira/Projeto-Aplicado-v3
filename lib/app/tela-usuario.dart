import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/globais/barra-superior.dart';
import 'components/globais/menu-inferior.dart';
import 'tela-login.dart';
import 'tela-inicio.dart';
import 'tela-mapa.dart';

class Perfil extends StatefulWidget {
  State<Perfil> createState() => _PerfilState(); //Função
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.grey[200], // Cor de fundo cinza claro
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height:
                  80, // Define o espaço de 20 pixels abaixo do Container
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: 320,
                    height: 335,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 23,
                          top: 117,
                          child: Container(width: 40, height: 40),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 320,
                            height: 363,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 103,
                          top: 24,
                          child: Text(
                            'Paulo da Silva',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 112,
                          child: Text(
                            'Celular: (49) 98800-9704',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 141,
                          child: Text(
                            'Email: paulodasilva@gmail.com.br',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 170,
                          child: Text(
                            'CPF: 981.025.357-03',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 138,
                          top: 224,
                          child: Text(
                            'Cargo:',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 17,
                          top: 255,
                          child: SizedBox(
                            width: 550,
                            height: 300,
                            child: Text(
                              'Agente de campo da área oeste de SC',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 132,
                          top: 48,
                          child: Text(
                            'ID: 1255',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Botão de sair
                Positioned(
                  left: 261,
                  top: 103,
                  child: Container(
                    width: 63,
                    height: 25,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 63,
                            height: 25,
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
                                      LoginApp()),
                            );
                          },
                          child: Positioned(
                            left: 15,
                            top: 7,
                            child: Container(
                              width: 57,
                              height: 25,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 15,
                                    top: 8,
                                    child: SizedBox(
                                      width: 50,
                                      height: 25,
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
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

              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: BarraSuperior(context),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}