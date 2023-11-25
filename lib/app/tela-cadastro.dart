import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/app-state.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';
import 'package:provider/provider.dart';

class CadastroApp extends StatefulWidget {
  @override
  _CadastroAppState createState() => _CadastroAppState();
}

class _CadastroAppState extends State<CadastroApp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmarSenhaController = TextEditingController();

  final UserController _userController = UserController.userController;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TEXTO "NOME"
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' Nome',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              // CAMPO NOME
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

              // TEXTO "EMAIL"
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' Email',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              // CAMPO EMAIL
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              SizedBox(height: 35),

              // TEXTO "SENHA"
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' Senha',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              // CAMPO SENHA
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
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),

              SizedBox(height: 35),

              // TEXTO "CONFIRME SUA SENHA"
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' Confirme sua senha',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              // CAMPO CONFIRME SUA SENHA
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
                  controller: _confirmarSenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BOTÃO CADASTRAR
                    ElevatedButton(
                      onPressed: () async {
                        // Verificar se as senhas coincidem antes de cadastrar
                        if (_senhaController.text == _confirmarSenhaController.text) {
                          try {
                            // Chamar o método de registro do controlador de usuário
                            await _userController.registerUser(context, UserModel(
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _senhaController.text,
                              ),
                            );
                            // Se o registro for bem-sucedido, redirecionar para a tela de início
                            appState.atualizarTela('inicio');
                            Navigator.pushNamed(context, '/tela-inicio');
                          } catch (e) {
                            // Se houver um erro durante o regix'stro, exibir uma mensagem
                            print("Erro ao cadastrar: $e");
                            // Aqui você pode exibir uma mensagem de erro para o usuário
                          }
                        } else {
                          // Senhas não coincidem, exibir mensagem ou tratar conforme necessário
                          print("As senhas não coincidem");
                          // Aqui você pode exibir uma mensagem para o usuário
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff1d3484),
                        minimumSize: Size(100, 40),
                        padding: EdgeInsets.all(20.0),
                      ),
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Você possui uma conta?",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                        TextButton(
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              color: Color(0xff1d3484),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pushNamed("/tela-login"),
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
