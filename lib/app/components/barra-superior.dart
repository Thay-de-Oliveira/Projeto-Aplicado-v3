import 'package:flutter/material.dart';

Widget BarraSuperior(BuildContext context) {
  return Container(
    //BARRA AZUL
    width: double.infinity,
    height: 57,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 57,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.00, -0.03),
                end: Alignment(-1, 0.03),
                colors: [Color(0xFF1A7CB2), Color(0xFF4BA1E0)],
              ),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 22.5, // Posiciona o logo no centro
          top: 8,
          child: Container(
            width: 45,
            height: 42.49,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imagens/logo-sem-fundo.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
