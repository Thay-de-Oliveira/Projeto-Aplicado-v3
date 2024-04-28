import 'package:flutter/material.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final UserController _userController = UserController.userController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //LOGO
              Container(
                margin: EdgeInsets.only(
                    bottom: 30.0), // Espaçamento abaixo da imagem
                child: Image.asset('assets/imagens/logo.png', width: 230),
              ),

              //TEXTO "USUÁRIO"
              Container(
                alignment: Alignment
                    .centerLeft, // Alinha o texto com o início do campo
                child: Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5), //Espaçamento entre o texto e o campo

              //CAMPO USUÁRIO
              Container(
                width: 315,
                height: 40,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.70, color: Color(0xFF091B4A)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadows: [
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 35),

              //Texto "SENHA"
              Container(
                alignment: Alignment
                    .centerLeft, // Alinha o texto com o início do campo
                child: Text(
                  ' Senha',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5), //Espaçamento entre o texto e o campo

              //CAMPO SENHA
              Container(
                width: 315,
                height: 40,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.70, color: Color(0xFF091B4A)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadows: [
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),

              //TEXTO "ESQUECI MINHA SENHA"
              SizedBox(
                  height:
                      30), // Espaço entre os campos e o link "Esqueci minha senha"
              TextButton(
                onPressed: () {
                  print('Esqueci minha senha');
                },
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 5),

              Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //BOTÃO LOGIN
                    ElevatedButton(
                      onPressed: () async {
                        await _userController.loginUser(
                          context,
                          _usernameController.text,
                          _passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1d3484),
                        minimumSize: Size(100, 40),
                        padding: EdgeInsets.all(20.0),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),

                    SizedBox(height: 30), // Espaço entre os botões

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Não possui uma conta?",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                        TextButton(
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                              color: Color(0xff1d3484),
                              fontWeight: FontWeight.bold, //Negrito
                            ),
                          ),
                          onPressed: () => {
                            Navigator.of(context).pushNamed("/tela-cadastro")
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
