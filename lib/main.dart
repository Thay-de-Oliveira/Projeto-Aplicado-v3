import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'app/app-state.dart';
import 'controllerBinding.dart';
import 'app/login/tela-login.dart';
import 'app/home/tela-inicio.dart';
import 'app/home/tela-mapa.dart';
import 'app/home/tela-usuario.dart';
import 'app/home/atendimentos/cadastro/tela-atendimento-forms.dart';

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
      initialBinding: ControllerBinding(),
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
      initialRoute: '/',
      routes: {
        '/': (context) => LoginApp(),
        '/tela-login': (context) => LoginApp(),
        '/tela-inicio': (context) => const Home(title: ''),
        '/tela-mapa': (context) => Mapa(),
        '/tela-usuario': (context) => Perfil(),
        '/tela-atendimento-forms': (context) => AtendimentoForms(),
      },
    );
  }
}