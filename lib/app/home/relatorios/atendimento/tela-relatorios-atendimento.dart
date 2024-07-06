import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/atendimento/atendimento-card-relatorio.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relatorios-acontecimento.dart';
import 'package:projetoaplicado/app/home/relatorios/recibos/tela-relatorios-recibo.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa-e-filtro.dart';
import '../../../components/globais/filtro-atendimento.dart';

class RelatorioAtendimento extends StatefulWidget {
  @override
  _RelatorioAtendimentoState createState() => _RelatorioAtendimentoState();
}

class _RelatorioAtendimentoState extends State<RelatorioAtendimento> {
  final AtendimentoController atendimentoController = Get.find<AtendimentoController>();
  final TextEditingController searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _dataInicio;
  DateTime? _dataFim;
  bool? _itensAssistencia;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // DateTime now = DateTime.now();
    // DateTime tenDaysAgo = now.subtract(Duration(days: 10));
    // _dataInicio = tenDaysAgo;
    // _dataFim = now;
    _loadAtendimentos();
  }

  Future<void> _loadAtendimentos() async {
    setState(() {
      _isLoading = true;
    });
    await atendimentoController.searchAtendimentos(
      term: _searchTerm,
      dataInicio: _dataInicio?.toIso8601String().split('T').first,
      dataFim: _dataFim?.toIso8601String().split('T').first,
      entregueItensAjuda: _itensAssistencia,
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
    _loadAtendimentos();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroAtendimento(
          subgrupos: atendimentoController.listAtendimentoObs.map((a) => a.tipoAtendimento).toSet().toList(),
          tiposAtendimento: atendimentoController.listAtendimentoObs.map((a) => a.tipoAtendimento).toSet().toList(),
          initialDataInicio: _dataInicio,
          initialDataFim: _dataFim,
          initialItensAssistencia: _itensAssistencia,
          onSave: (filters) {
            setState(() {
              _dataInicio = filters['dataInicio'];
              _dataFim = filters['dataFim'];
              _itensAssistencia = filters['itensAssistencia'];
            });
            _loadAtendimentos();
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
        onRefresh: _loadAtendimentos,
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
                                MaterialPageRoute(builder: (context) => RelatorioAcontecimento()),
                              );
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
                                    child: Image.asset('assets/imagens/icon-acontecimento-inativo.png'),
                                  ),
                                  SizedBox(height: 5.0), // Espaço entre o ícone e o texto
                                  Text(
                                    'Acontecimento',
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
                                    child: Image.asset('assets/imagens/icon-atendimento-ativo.png'),
                                  ),
                                  SizedBox(height: 5.0), // Espaço entre o ícone e o texto
                                  Text(
                                    'Atendimento',
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
                                MaterialPageRoute(builder: (context) => RelatorioRecibo()),
                              );
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
                                  SizedBox(height: 5.0), // Espaço entre o ícone e o texto
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
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Obx(() {
                              var atendimentos = atendimentoController.listAtendimentoObs
                                  .where((atendimento) => atendimento.pendente == true)
                                  .toList()
                                  ..sort((a, b) => b.dataSolicitacao.compareTo(a.dataSolicitacao));

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: atendimentos.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      AtendimentoCardRelatorio(atendimento: atendimentos[index]),
                                      SizedBox(height: 12), // Espaçamento entre os cards
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
}
