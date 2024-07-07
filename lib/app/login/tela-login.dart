import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';
import 'package:projetoaplicado/app/app-state.dart';

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double padding = width * 0.05;
            double fieldWidth = width * 0.8;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //LOGO
                    Container(
                      margin: const EdgeInsets.only(bottom: 30.0), // Espaçamento abaixo da imagem
                      child: Image.asset('assets/imagens/logo.png', width: fieldWidth * 0.7),
                    ),

                    //TEXTO "USUÁRIO"
                    Container(
                      alignment: Alignment.centerLeft, // Alinha o texto com o início do campo
                      width: fieldWidth,
                      child: const Text(
                        'Email',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5), //Espaçamento entre o texto e o campo

                    //CAMPO USUÁRIO
                    Container(
                      width: fieldWidth,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.70, color: Color(0xFF091B4A)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    //Texto "SENHA"
                    Container(
                      alignment: Alignment.centerLeft, // Alinha o texto com o início do campo
                      width: fieldWidth,
                      child: const Text(
                        'Senha',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5), //Espaçamento entre o texto e o campo

                    //CAMPO SENHA
                    Container(
                      width: fieldWidth,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.70, color: Color(0xFF091B4A)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),

                    //TEXTO "ESQUECI MINHA SENHA"
                    const SizedBox(height: 30), // Espaço entre os campos e o link "Esqueci minha senha"

                    const SizedBox(height: 5),

                    Container(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //BOTÃO LOGIN
                          ElevatedButton(
                            onPressed: () async {
                              String loginMessage = await _userController.loginUser(
                                _usernameController.text,
                                _passwordController.text,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(loginMessage),
                                  duration: Duration(seconds: 3),
                                )
                              );

                              if (loginMessage == "Login bem sucedido!") {
                                Provider.of<AppState>(context, listen: false).loadData();
                                Navigator.of(context).pushReplacementNamed('/tela-inicio');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff1d3484),
                              minimumSize: Size(fieldWidth * 0.5, 40),
                              padding: const EdgeInsets.all(20.0),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}