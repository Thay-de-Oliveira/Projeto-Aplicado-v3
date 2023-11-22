import 'package:flutter/material.dart';

class MenuInferior extends StatefulWidget {
  @override
  _MenuInferiorState createState() => _MenuInferiorState();
}

class _MenuInferiorState extends State<MenuInferior> {
  String telaAtual = 'inicio'; //Inicialmente, a tela de início está ativa
  Color corAtiva = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 71,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                telaAtual =
                'usuario'; // Quando você acessar a tela de perfil, define a tela atual como 'perfil'
              });
              Navigator.of(context).pushNamed('/tela-usuario');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  telaAtual == 'usuario'
                      ? 'assets/imagens/icon-perfil-ativo.png' // Imagem ativa para o perfil
                      : 'assets/imagens/icon-perfil.png', // Imagem padrão para o perfil
                ),
                SizedBox(height: 4),
                Text(
                  'Usuário',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.30,
                  ),
                ),
              ],
            ),
          ),

          // INÍCIO
          InkWell(
            onTap: () {
              setState(() {
                telaAtual =
                'inicio'; // Quando você acessar a tela de início, define a tela atual como 'inicio'
              });
              Navigator.of(context).pushNamed('/tela-inicio');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  telaAtual == 'inicio' ? 'assets/imagens/icon-home.png' : 'assets/imagens/icon-home-normal.png',
                  color: corAtiva,
                ),
                SizedBox(height: 4),
                Text(
                  'Início',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
