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

  Future<AcontecimentoModel> getAcontecimentoByProtocolo(String protocolo) async {
    isLoading.value = true;
    try {
      var response = await acontecimentoService.fetchAcontecimentoByProtocolo(protocolo);
      return response;
    } catch (e) {
      throw Exception('Erro ao buscar acontecimento: $e');
    } finally {
      isLoading.value = false;
      update();
    }
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

  Future<dynamic> updateAcontecimento(String protocolo, bool isPendente) async {
    isLoading.value = true;

    try {
      // Obtém o acontecimento correspondente ao protocolo
      var acontecimento = listAcontecimentoObs.firstWhere(
          (element) => element.numeroProtocolo == protocolo);

      if (acontecimento != null) {
        // Atualiza o estado "pendente" no modelo
        acontecimento.pendente = isPendente;

        // Chama o serviço para editar o acontecimento
        var response = await acontecimentoService.editAcontecimento(acontecimento);

        // Verifica a resposta do serviço
        if (response is AcontecimentoModel) {
          // Atualiza a lista de acontecimentos após a edição
          var index = listAcontecimentoObs.indexWhere(
              (element) => element.numeroProtocolo == protocolo);
          if (index != -1) {
            listAcontecimentoObs[index] = response;
          }
        } else {
          // Trate o erro, se necessário
          print('Erro durante a edição do acontecimento');
        }
      } else {
        // Trate o caso em que não foi encontrado um acontecimento correspondente
        print('Acontecimento não encontrado para o protocolo: $protocolo');
      }
    } catch (e) {
      // Trate o erro, se necessário
      print('Erro durante a edição do acontecimento: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}