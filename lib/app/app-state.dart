import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String telaAtual = 'inicio';

  AppState() {
    loadData();
  }

  void atualizarTela(String novaTela) {
    telaAtual = novaTela;
    notifyListeners();
    _saveData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    telaAtual = prefs.getString('telaAtual') ?? 'inicio';
    notifyListeners();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('telaAtual', telaAtual);
  }
}