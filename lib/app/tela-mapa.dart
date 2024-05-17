import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/globais/barra-superior.dart';
import 'components/globais/menu-inferior.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height:
                      80, // Define o espaço de 20 pixels abaixo do Container
                ),
                Center(
                  child: Container(
                    width: 138,
                    height: 49,
                    child: InkWell(
                      onTap: () {
                        MapsLauncher.launchQuery('R. Frei Bruno, 201 - Parque das Palmeiras, Chapecó - SC, 89803-785');
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
                                  'assets/imagens/icon-pendente.png'),
                            ),
                            SizedBox(
                                height:
                                5.0), //Espaço entre o ícone e o texto
                            Text(
                              'Pendente',
                              style: TextStyle(
                                fontSize: 16,
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

