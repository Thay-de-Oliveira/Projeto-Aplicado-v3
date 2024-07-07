import 'package:get/get.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/backend/controllers/relatorioAtendimentoController.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';
import 'package:projetoaplicado/backend/customHttpClient.dart';
import 'package:projetoaplicado/backend/services/usuarioService.dart';
import 'package:projetoaplicado/backend/services/acontecimentoService.dart';
import 'package:projetoaplicado/backend/services/atendimentoService.dart';
import 'package:projetoaplicado/backend/services/cidadaoService.dart';
import 'package:projetoaplicado/backend/services/relatorioAtendimentoService.dart';
import 'package:http/http.dart' as http;

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    final httpClient = http.Client();
    
    // Primeiro instanciar UserService com o httpClient padrão
    final userService = UserService(httpClient);

    // Inicializa CustomHttpClient passando o UserService
    final customHttpClient = CustomHttpClient(httpClient, userService);

    // Configurar UserService com customHttpClient
    userService.setClient(customHttpClient);

    // Serviços usando o CustomHttpClient configurado
    final acontecimentoService = AcontecimentoService(customHttpClient);
    final atendimentoService = AtendimentoService(customHttpClient);
    final cidadaoService = CidadaoService(customHttpClient);
    final relatorioAtendimentoService = RelatorioAtendimentoService(client: customHttpClient);

    // Controladores com seus respectivos serviços
    Get.lazyPut<CidadaoController>(() => CidadaoController(cidadaoService: cidadaoService));
    Get.lazyPut<AcontecimentoController>(() => AcontecimentoController(acontecimentoService: acontecimentoService));
    Get.lazyPut<UserController>(() => UserController(userService: userService));
    Get.lazyPut<AtendimentoController>(() => AtendimentoController(atendimentoService: atendimentoService));
    Get.lazyPut<RelatorioAtendimentoController>(() => RelatorioAtendimentoController(relatorioService: relatorioAtendimentoService));
  }
}