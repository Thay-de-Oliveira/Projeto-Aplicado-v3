import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';
import 'package:projetoaplicado/backend/services/usuarioService.dart';

class UserController extends GetxController {
  UserService userService;
  var isLoading = false.obs;
  UserModel? currentUser;

  UserController({required this.userService});

  Future<String> loginUser(String email, String password) async {
    isLoading.value = true;
    String message = '';

    try {
      currentUser = await userService.loginUser(email, password);
      if (currentUser != null) {
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

  Future<void> logoutUser() async {
    await userService.logoutUser();
    currentUser = null;
    update();
  }

  Future<void> refreshToken() async {
    try {
      await userService.refreshAccessToken();
    } catch (e) {
      await logoutUser();
      Get.offAllNamed('/login');
    }
  }

  Future<void> loadUserFromStorage() async {
    isLoading.value = true;
    try {
      UserModel? user = await userService.getUserFromStorage();
      if (user != null) {
        currentUser = user;
      } else {
        await logoutUser();
        Get.offAllNamed('/login');
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }
}