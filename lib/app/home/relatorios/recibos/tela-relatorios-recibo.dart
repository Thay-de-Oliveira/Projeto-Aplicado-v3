import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/globais/filtro-atendimento.dart';
import 'package:projetoaplicado/app/components/recibo/recibo-card-relatorio.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relatorios-acontecimento.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorios-atendimento.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa-e-filtro.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/app/components/globais/filtro-recibo.dart';

class RelatorioRecibo extends StatefulWidget {
  @override
  _RelatorioReciboState createState() => _RelatorioReciboState();
}

class _RelatorioReciboState extends State<RelatorioRecibo> {
  final AtendimentoController atendimentoController = Get.find<AtendimentoController>();
  final TextEditingController searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _dataInicio;
  DateTime? _dataFim;

  @override
  void initState() {
    super.initState();
    _loadRecibos();
  }

  Future<void> _loadRecibos() async {
    await atendimentoController.searchAtendimentos(
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
    _loadRecibos();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroRecibo(
          initialDataInicio: _dataInicio,
          initialDataFim: _dataFim,
          onSave: (filters) {
            setState(() {
              _dataInicio = filters['dataInicio'];
              _dataFim = filters['dataFim'];
            });
            _loadRecibos();
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
        onRefresh: _loadRecibos,
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
                                  SizedBox(height: 5.0),
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
                                MaterialPageRoute(builder: (context) => RelatorioAtendimento()),
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
                              width: 110,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset('assets/imagens/icon-recibos-ativo.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Recibos',
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
                      child: Obx(() {
                        if (atendimentoController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var AtendimentosComItensEntregues = atendimentoController.listAtendimentoObs
                              .where((atendimento) => atendimento.entregueItensAjuda == true)
                              .toList();

                          if (AtendimentosComItensEntregues.isEmpty) {
                            return Center(
                              child: Text('Nenhum atendimento encontrado'),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: AtendimentosComItensEntregues.length,
                            itemBuilder: (context, index) {
                              AtendimentosModel atendimento = AtendimentosComItensEntregues[index];
                              return Column(
                                children: [
                                  ReciboCardRelatorio(atendimento: atendimento),
                                  SizedBox(height: 12),
                                ],
                              );
                            },
                          );
                        }
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
