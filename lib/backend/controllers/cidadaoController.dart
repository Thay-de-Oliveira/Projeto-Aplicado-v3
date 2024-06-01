import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/backend/services/cidadaoService.dart';

class CidadaoController extends GetxController {
  CidadaoService cidadaoService = CidadaoService();
  var isLoading = false.obs;
  var listCidadaoObs = <CidadaoModel>[].obs;

  static CidadaoController get cidadaoController => Get.find();

  Future<dynamic> post(CidadaoModel cidadao) async {
    isLoading.value = true;
    var response = await cidadaoService.postCidadao(cidadao);
    isLoading.value = false;
    update();
    return response;
  }

  Future<void> fetchCidadaoByQuery(String query) async {
    isLoading(true);
    try {
      var cidadaos = await cidadaoService.fetchListCidadao(searchTerm: query);
      listCidadaoObs.value = cidadaos;
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível realizar a busca: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCidadaoByCpf(String cpf) async {
    isLoading(true);
    try {
      var cidadao = await cidadaoService.getCidadaoByCpf(cpf);
      listCidadaoObs.assignAll([cidadao]);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível encontrar o cidadão: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCidadaoByCpf(String cpf, CidadaoModel cidadao) async {
    isLoading(true);
    try {
      var updatedCidadao = await cidadaoService.updateCidadaoByCpf(cpf, cidadao);
      int index = listCidadaoObs.indexWhere((c) => c.cpf == cpf);
      if (index != -1) {
        listCidadaoObs[index] = updatedCidadao;
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao atualizar o cidadão: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteCidadaoByCpf(String cpf) async {
    isLoading(true);
    try {
      bool deleted = await cidadaoService.deleteCidadaoByCpf(cpf);
      if (deleted) {
        listCidadaoObs.removeWhere((c) => c.cpf == cpf);
      }
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível deletar o cidadão: $e');
    } finally {
      isLoading(false);
    }
  }
}
