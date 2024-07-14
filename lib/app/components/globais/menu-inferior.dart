import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/app-state.dart';
import 'package:provider/provider.dart';

class MenuInferior extends StatefulWidget {
  @override
  _MenuInferiorState createState() => _MenuInferiorState();
}

class _MenuInferiorState extends State<MenuInferior> {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    return Container(
      width: 360,
      height: 71,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              appState.atualizarTela('usuario');
              Navigator.of(context).pushReplacementNamed('/tela-usuario');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  appState.telaAtual == 'usuario'
                      ? 'assets/imagens/icon-perfil-ativo.png' // Imagem ativa para o perfil
                      : 'assets/imagens/icon-perfil.png', // Imagem padrão para o perfil
                ),
                SizedBox(height: 4),
                Text(
                  'Usuário',
                  style: TextStyle(
                    color: appState.telaAtual == 'usuario' ? Colors.blue : Color(0xff999999),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.30,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              appState.atualizarTela('inicio');
              Navigator.of(context).pushNamedAndRemoveUntil('/tela-inicio', (Route<dynamic> route) => false);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  appState.telaAtual == 'inicio' ? 'assets/imagens/icon-home.png' : 'assets/imagens/icon-home-normal.png',
                ),
                SizedBox(height: 4),
                Text(
                  'Início',
                  style: TextStyle(
                    color: appState.telaAtual == 'inicio' ? Colors.blue : Color(0xff999999),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
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
