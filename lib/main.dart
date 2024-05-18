import 'package:flutter/material.dart';
import 'package:projetoaplicado/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/components/globais/menu-inferior.dart';
import 'app/components/globais/barra-superior.dart';

import 'app/home/atendimentos/cadastro/tela-atendimento-forms.dart';
import 'app/login/tela-cadastro.dart';
import 'app/home/tela-inicio.dart';
import 'app/app-state.dart';

import 'app/home/tela-inicio.dart';
import 'app/login/tela-login.dart';
import 'app/tela-mapa.dart';
import 'app/home/tela-usuario.dart';
import 'app/home/atendimentos/cadastro/foto-camera.dart';
import 'app/home/atendimentos/cadastro/foto-upload.dart';

import 'controllerBinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      initialRoute: '/', // Rota inicial
      routes: {
        '/': (context) => LoginApp(), // Login
        '/tela-cadastro': (context) => CadastroApp(),
        '/tela-login': (context) => LoginApp(),
        '/tela-inicio': (context) => const Home(
              title: '',
            ),
        '/tela-mapa': (context) => Mapa(),
        '/tela-usuario': (context) => Perfil(),
        '/tela-atendimento-forms': (context) => AtendimentoForms(),
        '/camera': (context) => Camera(),
        '/upload': (context) => Upload(),
      },
    );
  }
}
