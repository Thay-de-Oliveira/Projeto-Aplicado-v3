import '../services/cepService.dart';

class CepController {
  final CepService _cepService = CepService();

  Future<Map<String, dynamic>?> buscarCep(String cep) async {
    return await _cepService.buscarCep(cep);
  }
}