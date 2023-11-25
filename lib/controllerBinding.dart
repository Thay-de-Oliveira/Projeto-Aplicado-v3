import 'package:get/get.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';
import 'backend/controllers/cidadaoController.dart';

class ControllerBinding implements Bindings  {
  @override
  void dependencies(){
    Get.lazyPut<CidadaoController>(() => CidadaoController());
    Get.lazyPut<AcontecimentoController>(() => AcontecimentoController());
    Get.lazyPut<UserController>(() => UserController());
  }
}