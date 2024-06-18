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

  void searchByWord(String query) {
    var filteredList = listAcontecimentoObs.where((acontecimento) {
      var searchString = '${acontecimento.classe} ${acontecimento.grupo} ${acontecimento.subgrupo} ${acontecimento.tipo} ${acontecimento.subtipo} ${acontecimento.infoCobrade} ${acontecimento.numeroProtocolo ?? ''}'.toLowerCase();
      return searchString.contains(query.toLowerCase());
    }).toList();
    listAcontecimentoObs.value = filteredList;
  }

  void filterAcontecimentoPendente(Map<String, dynamic> filters) {
    var filteredList = listAcontecimentoObs.where((acontecimento) {
      bool matches = true;

      if (filters['subgrupo'] != null && filters['subgrupo'].isNotEmpty) {
        matches &= acontecimento.subgrupo == filters['subgrupo'];
      }
      if (filters['protocolo'] != null && filters['protocolo'].isNotEmpty) {
        matches &= acontecimento.numeroProtocolo?.contains(filters['protocolo']) ?? false;
      }
      if (filters['dataInicio'] != null && filters['dataFim'] != null) {
        matches &= acontecimento.dataHora.isAfter(filters['dataInicio']) &&
                   acontecimento.dataHora.isBefore(filters['dataFim']);
      }
      if (filters['bairro'] != null && filters['bairro'].isNotEmpty) {
        matches &= acontecimento.infoCobrade.contains(filters['bairro']);
      }

      return matches;
    }).toList();

    listAcontecimentoObs.value = filteredList;
  }

  void filterAtendimentoAcontecimentoHistorico(Map<String, dynamic> filters) {
    var filteredList = listAcontecimentoObs.where((acontecimento) {
      bool matches = true;

      if (filters['subgrupo'] != null && filters['subgrupo'].isNotEmpty) {
        matches &= acontecimento.subgrupo == filters['subgrupo'];
      }
      if (filters['protocolo'] != null && filters['protocolo'].isNotEmpty) {
        matches &= acontecimento.numeroProtocolo?.contains(filters['protocolo']) ?? false;
      }
      if (filters['dataInicio'] != null && filters['dataFim'] != null) {
        matches &= acontecimento.dataHora.isAfter(filters['dataInicio']) &&
                   acontecimento.dataHora.isBefore(filters['dataFim']);
      }

      return matches;
    }).toList();

    listAcontecimentoObs.value = filteredList;
  }
}
