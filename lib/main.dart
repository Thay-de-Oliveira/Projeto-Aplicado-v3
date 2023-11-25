import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/components/menu-inferior.dart';
import 'app/components/barra-superior.dart';

import 'app/tela-atendimento-forms.dart';
import 'app/tela-cadastro.dart';
import 'app/tela-inicio.dart';
import 'app/app-state.dart';

import 'app/tela-inicio.dart';
import 'app/tela-login.dart';
import 'app/tela-mapa.dart';
import 'app/tela-usuario.dart';

import 'controllerBinding.dart';

void main() {
  ControllerBinding().dependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', //Rota inicial
      routes: {
        '/': (context) => LoginApp(), //Login
        '/tela-cadastro': (context) => CadastroApp(),
        '/tela-inicio': (context) => const Home(
              title: '',
            ),
        '/tela-mapa': (context) => Mapa(),
        '/tela-usuario': (context) => Perfil(),
        '/tela-atendimento-forms': (context) => AtendimentoForms(),
        //'/tela-atend-detalhes-historico': (context) => DetalhesHistorico(),
      },
    );
  }
}
