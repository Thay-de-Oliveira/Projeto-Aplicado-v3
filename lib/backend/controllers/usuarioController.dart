import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';
import 'package:projetoaplicado/backend/services/usuarioService.dart';

class UserController extends GetxController {
  UserService userService = UserService();
  var isLoading = false.obs;
  UserModel? currentUser;

  static UserController get userController => Get.find();

  Future<String> loginUser(String email, String password) async {
    isLoading.value = true;
    UserModel? user;
    String message = '';

    try {
      user = await userService.loginUser(email, password);
      if (user != null) {
        currentUser = user;
        message = "Login bem sucedido!";
      } else {
        message = "Usuário ou senha incorretos";
      }
    } catch (e) {
      message = "Erro ao fazer login";
    } finally {
      isLoading.value = false;
      update();
    }

    return message;
  }
}