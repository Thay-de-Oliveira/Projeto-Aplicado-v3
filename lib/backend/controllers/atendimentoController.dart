import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/services/atendimentoService.dart';

class AtendimentoController extends GetxController {
  AtendimentoService atendimentoService = AtendimentoService();
  var isLoading = false.obs;
  var listAtendimentoObs = <AtendimentosModel>[].obs;

  static AtendimentoController get atendimentoController => Get.find();

  Future<dynamic> listAtendimento() async {
    isLoading.value = true;
    var list = await atendimentoService.fetchListAtendimento();
    listAtendimentoObs.value = list;
    isLoading.value = false;
    update();
    return listAtendimentoObs;
  }

  Future<dynamic> getAtendimentoById(String id) async {
    isLoading.value = true;
    var response = await atendimentoService.getAtendimentoById(id);
    isLoading.value = false;
    update();
    return response;
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

Future<dynamic> editAtendimento(AtendimentosModel atendimento, bool isPendente) async {
  isLoading.value = true;

  try {
    // Atualiza o estado "pendente" no modelo
    atendimento.pendente = isPendente;

    // Chama o serviço para editar o atendimento
    var response = await atendimentoService.editAtendimento(atendimento);

    // Verifica a resposta do serviço
    if (response is AtendimentosModel) {
      // Atualiza a lista de atendimentos após a edição
      var index = listAtendimentoObs.indexWhere((element) => element.id == atendimento.id);
      if (index != -1) {
        listAtendimentoObs[index] = response;
      }
    } else {
      // Trate o erro, se necessário
      print('Erro durante a edição do atendimento');
    }
  } catch (e) {
    // Trate o erro, se necessário
    print('Erro durante a edição do atendimento: $e');
  } finally {
    isLoading.value = false;
    update();
  }
}
}
