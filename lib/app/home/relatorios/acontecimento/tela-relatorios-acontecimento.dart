import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorios-atendimento.dart';
import 'package:projetoaplicado/app/home/relatorios/recibos/tela-relatorios-recibo.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/acontecimento/acontecimento-card-relatorio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';

import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa-e-filtro.dart';
import 'package:projetoaplicado/app/components/globais/filtro-acontecimento.dart';

class RelatorioAcontecimento extends StatefulWidget {
  @override
  _RelatorioAcontecimentoState createState() => _RelatorioAcontecimentoState();
}

class _RelatorioAcontecimentoState extends State<RelatorioAcontecimento> {
  final AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());
  final TextEditingController searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _dataInicio;
  DateTime? _dataFim;

  @override
  void initState() {
    super.initState();
    _loadAcontecimentos();
  }

  Future<void> _loadAcontecimentos() async {
    DateTime now = DateTime.now();
    DateTime tenDaysAgo = now.subtract(Duration(days: 10));
    setState(() {
      _dataInicio = tenDaysAgo;
      _dataFim = now;
    });
    await acontecimentoController.searchAcontecimentos(
      term: _searchTerm,
      dataInicio: _dataInicio?.toIso8601String().split('T').first,
      dataFim: _dataFim?.toIso8601String().split('T').first,
      limit: 10,
      page: 1,
    );
  }

  void _onSearch(String query) {
    setState(() {
      _searchTerm = query;
    });
    acontecimentoController.searchAcontecimentos(
      term: query,
      dataInicio: _dataInicio?.toIso8601String().split('T').first,
      dataFim: _dataFim?.toIso8601String().split('T').first,
      limit: 10,
      page: 1,
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroAcontecimento(
          subgrupos: acontecimentoController.listAcontecimentoObs.map((a) => a.subgrupo ?? '').toSet().toList(),
          initialDataInicio: _dataInicio,
          initialDataFim: _dataFim,
          onSave: (filters) {
            setState(() {
              _dataInicio = filters['dataInicio'];
              _dataFim = filters['dataFim'];
            });
            acontecimentoController.searchAcontecimentos(
              term: _searchTerm,
              dataInicio: _dataInicio?.toIso8601String().split('T').first,
              dataFim: _dataFim?.toIso8601String().split('T').first,
              limit: 10,
              page: 1,
            );
          },
        );
      },
    );
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
                            onTap: () {
                            },
                            child: Container(
                              width: 110,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset('assets/imagens/icon-acontecimento-ativo.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Acontecimento',
                                    style: TextStyle(
                                      fontSize: 14,
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
                        child: Ink(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RelatorioAtendimento()));
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
                                    child: Image.asset('assets/imagens/icon-atendimento-inativo.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Atendimento',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Ink(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RelatorioRecibo()));
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
                                    child: Image.asset('assets/imagens/icon-recibos-inativo.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Recibos',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  SearchFilterBar(
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
                  SizedBox(height: 25),
                  Center(
                    child: Container(
                      width: 330,
                      child: FutureBuilder(
                        future: _loadAcontecimentos(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Erro ao carregar atendimentos'),
                                );
                              } else {
                                var acontecimentos = acontecimentoController.listAcontecimentoObs
                                    .where((acontecimento) => acontecimento.pendente == false)
                                    .toList()
                                    ..sort((a, b) => b.dataHora.compareTo(a.dataHora));

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: acontecimentos.length,
                                  itemBuilder: (context, index) {
                                    return AcontecimentoCardRelatorio(acontecimento: acontecimentos[index]);
                                  },
                                );
                              }
                            default:
                              return SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}