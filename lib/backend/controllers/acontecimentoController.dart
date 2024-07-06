import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/services/acontecimentoService.dart';

class AcontecimentoController extends GetxController {
  late AcontecimentoService acontecimentoService;
  var isLoading = false.obs;
  var listAcontecimentoObs = <AcontecimentoModel>[].obs;

  static AcontecimentoController get acontecimentoController => Get.find();

  AcontecimentoController({required this.acontecimentoService});

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

  Future<void> updateAcontecimento(String protocolo, bool isPendente) async {
    isLoading(true);

    try {
      var index = listAcontecimentoObs.indexWhere((element) => element.numeroProtocolo == protocolo);

      if (index == -1) {
        print('Acontecimento não encontrado para o protocolo: $protocolo');
        return;
      }

      AcontecimentoModel acontecimento = listAcontecimentoObs[index];
      acontecimento.pendente = isPendente;
      AcontecimentoModel response = await acontecimentoService.editAcontecimento(acontecimento);

      listAcontecimentoObs[index] = response;
      print('Acontecimento atualizado com sucesso.');
    } catch (e) {
      print('Erro durante a edição do acontecimento: $e');
    } finally {
      isLoading(false);
      update();
    }
  }

  // Método para pesquisa avançada
  Future<void> searchAcontecimentos({
    required String term,
    String? dataInicio,
    String? dataFim,
    int limit = 10,
    int page = 1,
  }) async {
    isLoading.value = true;
    try {
      var list = await acontecimentoService.searchAcontecimentos(
        term: term,
        dataInicio: dataInicio,
        dataFim: dataFim,
        limit: limit,
        page: page,
      );
      listAcontecimentoObs.value = list;
    } catch (e) {
      print('Erro ao buscar acontecimentos: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}