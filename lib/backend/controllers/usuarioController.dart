import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';
import 'package:projetoaplicado/backend/services/usuarioService.dart';


class UserController extends GetxController {
  UserService userService = UserService();
  var isLoading = false.obs;

  static UserController get userController => Get.find();

  Future<void> registerUser(BuildContext context, UserModel user) async {
    try {
      isLoading.value = true;
      await userService.registerUser(user);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário registrado com sucesso"),
        duration: Duration(seconds: 3),
      ));
      Navigator.of(context).pushReplacementNamed('/tela-inicio');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Falha ao cadastrar usuário"),
        duration: Duration(seconds: 3),
      ));
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      isLoading.value = true;
      bool loginSuccess = await userService.loginUser(email, password);

      if (loginSuccess) {
        // Login bem-sucedido
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login bem sucedido!"),
          duration: Duration(seconds: 3),
        ));
        Navigator.of(context).pushReplacementNamed('/tela-inicio');
      } else {
        // Login falhou, exibir mensagem
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Usuário ou senha incorretos"),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Erro ao fazer login"),
        duration: Duration(seconds: 3),
      ));
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
