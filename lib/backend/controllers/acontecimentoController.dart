import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/services/acontecimentoService.dart';


class AcontecimentoController extends GetxController {
  AcontecimentoService acontecimentoService = AcontecimentoService();
  var isLoading = false.obs;
  var listAcontecimentoObs = <AcontecimentoModel>[].obs;

  static AcontecimentoController get acontecimentoController => Get.find();

  Future<dynamic> listAcontecimento() async {
    isLoading.value = true;
    var list = await acontecimentoService.fetchListAcontecimento();
    listAcontecimentoObs.value = list;
    isLoading.value = false;
    update();
    return listAcontecimentoObs;
  }

  Future<dynamic> post(AcontecimentoModel acontecimento) async {
    isLoading.value = true;
    var response = await acontecimentoService.postAcontecimento(acontecimento);
    isLoading.value = false;
    update();
    return response;
  }

  Future<dynamic> deleteAcontecimento(String id) async {
    isLoading.value = true;
    var response = await acontecimentoService.deleteAcontecimento(id);
    isLoading.value = false;
    update();
    return response;
  }

  Future<dynamic> editAcontecimento(AcontecimentoModel acontecimento) async {
    isLoading.value = true;
    var response = await acontecimentoService.editAcontecimento(acontecimento);
    isLoading.value = false;
    update();
    return response;
  }
}
