import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projetoaplicado/app/app-state.dart';
import 'package:projetoaplicado/app/home/atendimentos/cadastro/tela-atendimento-forms.dart';
import 'package:projetoaplicado/app/home/cidadaos/cadastro/tela-forms-cidadao.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relatorios-acontecimento.dart';
import 'package:projetoaplicado/app/home/acontecimentos/tela-acontecimentos-forms.dart';
import '../components/globais/barra-superior.dart';
import '../components/globais/menu-inferior.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    var appState = Provider.of<AppState>(context, listen: false);
    appState.loadData(); // Carrega os dados ao iniciar
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          BarraSuperior(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  buildMenuCard(
                    context,
                    'Acontecimentos',
                    'assets/imagens/chuva-icone.png',
                    Colors.lightBlueAccent,
                    AcontecimentosForms(),
                    appState,
                    'acontecimentos',
                  ),
                  SizedBox(height: 25),
                  buildMenuCard(
                    context,
                    'Atendimentos',
                    'assets/imagens/fone-icone.png',
                    Colors.greenAccent,
                    AtendimentoForms(),
                    appState,
                    'atendimento',
                  ),
                  SizedBox(height: 25),
                  buildMenuCard(
                    context,
                    'Cidadãos',
                    'assets/imagens/cadastro-icone.png',
                    Colors.orangeAccent,
                    CadastroCidadao(),
                    appState,
                    'cadastro_cidadao',
                  ),
                  SizedBox(height: 25),
                  buildMenuCard(
                    context,
                    'Relatórios',
                    'assets/imagens/icon-relatorio.png',
                    Colors.yellowAccent,
                    RelatorioAcontecimento(),
                    appState,
                    'relatorios',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget buildMenuCard(BuildContext context, String title, String imagePath, Color circleColor, Widget navigateTo, AppState appState, String tela) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: InkWell(
        onTap: () {
          appState.atualizarTela(tela);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => navigateTo,
            ),
          );
        },
        child: Container(
          width: screenWidth * 0.9,
          height: 85,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFEEEEFF)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x7FB0DCEE),
                blurRadius: 8,
                offset: Offset(1, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
