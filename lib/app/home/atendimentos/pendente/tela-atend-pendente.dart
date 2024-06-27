import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/acontecimento/acontecimento-card.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import '../../../components/globais/barra-pesquisa-e-filtro.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/filtro-acontecimento.dart';
import '../../../components/globais/menu-inferior.dart';
import '../historico/tela-atend-historico.dart';
import '../cadastro/tela-atendimento-forms.dart';

class AtendimentoPendente extends StatefulWidget {
  @override
  _AtendimentoPendenteState createState() => _AtendimentoPendenteState();
}

class _AtendimentoPendenteState extends State<AtendimentoPendente> {
  final AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());
  final TextEditingController searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _dataInicio;
  DateTime? _dataFim;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime tenDaysAgo = now.subtract(Duration(days: 10));
    _dataInicio = tenDaysAgo;
    _dataFim = now;
    _loadAcontecimentos();
  }

  Future<void> _loadAcontecimentos() async {
    setState(() {
      _isLoading = true;
    });
    await acontecimentoController.searchAcontecimentos(
      term: _searchTerm,
      dataInicio: _dataInicio?.toIso8601String().split('T').first,
      dataFim: _dataFim?.toIso8601String().split('T').first,
      limit: 10,
      page: 1,
    );
    setState(() {
      _isLoading = false;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _searchTerm = query;
    });
    _loadAcontecimentos();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroAcontecimento(
          subgrupos: acontecimentoController.listAcontecimentoObs.map((a) => a.subgrupo).toSet().toList(),
          initialDataInicio: _dataInicio,
          initialDataFim: _dataFim,
          onSave: (filters) {
            setState(() {
              _dataInicio = filters['dataInicio'];
              _dataFim = filters['dataFim'];
            });
            _loadAcontecimentos();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: RefreshIndicator(
        onRefresh: _loadAcontecimentos,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: false,
              expandedHeight: 50,
              flexibleSpace: BarraSuperior(context),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: buildMenuButton(
                          'Cadastro',
                          'assets/imagens/icon-cadastro.png',
                          AtendimentoForms(),
                        ),
                      ),
                      GestureDetector(
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: Color(0xFFBBD8F0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 2,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 90,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset('assets/imagens/icon-pendente-ativo.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Pendente',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: buildMenuButton(
                          'Histórico',
                          'assets/imagens/icon-historico.png',
                          HistoricoAtendimento(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: SearchFilterBar(
                          searchController: searchController,
                          onSearch: (query) {
                            if (query.isEmpty) {
                              _onSearch('');
                            } else {
                              _onSearch(query);
                            }
                          },
                          onFilter: _showFilterDialog,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Container(
                      width: 330,
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Obx(() {
                              var pendentes = acontecimentoController.listAcontecimentoObs
                                  .where((acontecimento) => acontecimento.pendente == true)
                                  .toList()
                                  ..sort((a, b) => b.dataHora.compareTo(a.dataHora));

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: pendentes.length,
                                itemBuilder: (context, index) {
                                  AcontecimentoModel acontecimento = pendentes[index];
                                  return Column(
                                    children: [
                                      AcontecimentoCard(acontecimento: acontecimento),
                                      SizedBox(height: 12), //Espaçamento entre cards
                                    ],
                                  );
                                },
                              );
                            }),
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget buildMenuButton(String text, String imagePath, Widget destination) {
    return Ink(
      decoration: ShapeDecoration(
        color: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 2,
            offset: Offset(2, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        },
        child: Container(
          width: 90,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                child: Image.asset(imagePath),
              ),
              SizedBox(height: 5.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
