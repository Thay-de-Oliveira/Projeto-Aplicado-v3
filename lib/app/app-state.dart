import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String telaAtual = 'inicio';

  void atualizarTela(String novaTela) {
    telaAtual = novaTela;
    notifyListeners();
  }
}
