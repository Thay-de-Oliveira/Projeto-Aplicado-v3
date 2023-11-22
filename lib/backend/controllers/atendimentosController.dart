import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/services/atendimentoService.dart';


class AtendimentoController extends GetxController {
  AtendimentosService atendimentosService = AtendimentosService();
  var isLoading = false.obs;
  var listAtendimentosObs = <AtendimentosModel>[].obs;

  static AtendimentoController get AtendimentoController => Get.find();

  Future<dynamic> listAtendimento() async {
    isLoading.value = true;
    var list = await atendimentoService.fetchListAtendimento();
    listAtendimentosObs.value = list;
    isLoading.value = false;
    update();
    return listAtendimentosObs;
  }

  Future<dynamic> post(AtendimentosModel atendimento) async {
    isLoading.value = true;
    var response = await atendimentoService.postAtendimento(atendimento);
    isLoading.value = false;
    update();
    return response;
  }

  Future<dynamic> deleteAtendimento(String id) async {
    isLoading.value = true;
    var response = await atendimentoService.deleteAtendimento(id);
    isLoading.value = false;
    update();
    return response;
  }

  Future<dynamic> editAtendimento(AtendimentosModel atendimento) async {
    isLoading.value = true;
    var response = await atendimentoService.editAtendimento(atendimento);
    isLoading.value = false;
    update();
    return response;
  }
}
