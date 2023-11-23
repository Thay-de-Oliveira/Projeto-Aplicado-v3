import 'package:get/get.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'backend/controllers/cidadaoController.dart';
import 'backend/controllers/atendimentosController.dart';

class ControllerBinding implements Bindings  {
  @override
  void dependencies(){
    Get.lazyPut<CidadaoController>(() => CidadaoController());
    Get.lazyPut<AcontecimentoController>(() => AcontecimentoController());
    Get.lazyPut<AtendimentoController>(()=> AtendimentoController())
  }

}