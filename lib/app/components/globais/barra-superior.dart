import 'package:flutter/material.dart';

Widget BarraSuperior(BuildContext context) {
  bool isHome = ModalRoute.of(context)?.isFirst ?? false;

  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: double.infinity,
        height: 57,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: constraints.maxWidth,
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
            if (!isHome)
              Positioned(
                left: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            Positioned(
              left: (constraints.maxWidth / 2) - 22.5, // Centraliza o logo
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
    },
  );
}
