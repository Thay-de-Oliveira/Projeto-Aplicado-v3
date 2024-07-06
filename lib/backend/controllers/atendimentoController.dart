import 'dart:io';
import 'package:get/get.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/services/atendimentoService.dart';

class AtendimentoController extends GetxController {
  late AtendimentoService atendimentoService;
  var isLoading = false.obs;
  var listAtendimentoObs = <AtendimentosModel>[].obs;

  static AtendimentoController get atendimentoController => Get.find();

  AtendimentoController({required this.atendimentoService});

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

  Future<dynamic> post(AtendimentosModel atendimento, List<File> imageFiles) async {
    isLoading.value = true;
    try {
      var response = await atendimentoService.postAtendimento(atendimento, imageFiles);
      isLoading.value = false;
      update();
      return response;
    } catch (e) {
      print('Erro ao enviar o atendimento: $e');
      isLoading.value = false;
      update();
      return null;
    }
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
      atendimento.pendente = isPendente;

      var response = await atendimentoService.editAtendimento(atendimento);

      var index = listAtendimentoObs.indexWhere((element) => element.id == atendimento.id);
      if (index != -1) {
        listAtendimentoObs[index] = response;
      }
    } catch (e) {
      print('Erro durante a edição do atendimento: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> searchAtendimentos({
    String? term,
    String? dataInicio,
    String? dataFim,
    bool? entregueItensAjuda,
    int limit = 10,
    int page = 1,
  }) async {
    isLoading(true);
    try {
      var atendimentos = await atendimentoService.searchAtendimentos(
        term: term,
        dataInicio: dataInicio,
        dataFim: dataFim,
        entregueItensAjuda: entregueItensAjuda,
        limit: limit,
        page: page,
      );
      listAtendimentoObs.assignAll(atendimentos);
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao buscar atendimentos');
    } finally {
      isLoading(false);
    }
  }
}