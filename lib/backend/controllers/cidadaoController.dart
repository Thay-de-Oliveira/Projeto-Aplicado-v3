import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/backend/services/cidadaoService.dart';

class CidadaoController extends GetxController {
  CidadaoService cidadaoService = CidadaoService();
  var isLoading = false.obs;
  var listCidadaoObs = <CidadaoModel>[].obs;

  static CidadaoController get cidadaoController => Get.find();

  Future<dynamic> listCidadao() async {
    isLoading.value = true;
    var list = await cidadaoService.fetchListCidadao();
    listCidadaoObs.value = list;
    isLoading.value = false;
    update();
    return listCidadaoObs;
  }

  Future<dynamic> post(CidadaoModel cidadao) async {
    isLoading.value = true;
    var response = await cidadaoService.postCidadao(cidadao);
    isLoading.value = false;
    update();
    return response;
  }

  Future<dynamic> deleteCidadao(String id) async {
    isLoading.value = true;
    var response = await cidadaoService.deleteCidadao(id);
    isLoading.value = false;
    update();
    return response;
  }

  Future<dynamic> editCidadao(CidadaoModel cidadao) async {
    isLoading.value = true;
    var response = await cidadaoService.editCidadao(cidadao);
    isLoading.value = false;
    update();
    return response;
  }
}
