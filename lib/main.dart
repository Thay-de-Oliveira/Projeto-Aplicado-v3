import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'app/components/globais/menu-inferior.dart';
import 'app/components/globais/barra-superior.dart';

import 'app/home/atendimentos/cadastro/tela-atendimento-forms.dart';
import 'app/login/tela-cadastro.dart';
import 'app/home/tela-inicio.dart';
import 'app/app-state.dart';

import 'app/home/tela-inicio.dart';
import 'app/login/tela-login.dart';
import 'app/home/tela-mapa.dart';
import 'app/home/tela-usuario.dart';

import 'backend/services/usuarioService.dart';
import 'backend/services/acontecimentoService.dart';
import 'backend/controllers/acontecimentoController.dart';
import 'controllerBinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return GetMaterialApp(
      initialBinding: ControllerBinding(), // Configurar o binding aqui
      theme: ThemeData(
        primaryColor: Color(0xFF1B7CB3),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF1B7CB3),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1B7CB3),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1B7CB3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelStyle: TextStyle(
            color: Color(0xFF1B7CB3),
          ),
          floatingLabelStyle: TextStyle(
            color: Color(0xFF1B7CB3),
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Color(0xFF1B7CB3),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1B7CB3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelStyle: TextStyle(
              color: Color(0xFF1B7CB3),
            ),
          ),
        ),
      ),
      initialRoute: '/', // Rota inicial
      routes: {
        '/': (context) => LoginApp(), // Login
        //'/tela-cadastro': (context) => CadastroApp(),
        '/tela-login': (context) => LoginApp(),
        '/tela-inicio': (context) => const Home(title: ''),
        '/tela-mapa': (context) => Mapa(),
        '/tela-usuario': (context) => Perfil(),
        '/tela-atendimento-forms': (context) => AtendimentoForms(),
      },
    );
  }
}