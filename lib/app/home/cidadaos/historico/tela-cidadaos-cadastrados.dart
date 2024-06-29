import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/cidadao/cidadao-card.dart';
import 'package:projetoaplicado/app/components/globais/filtro-cidadao.dart';
import 'package:projetoaplicado/app/components/globais/barra-superior.dart';
import 'package:projetoaplicado/app/components/globais/menu-inferior.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/app/home/cidadaos/cadastro/tela-forms-cidadao.dart';

class HistoricoCidadao extends StatefulWidget {
  @override
  _HistoricoCidadaoState createState() => _HistoricoCidadaoState();
}

class _HistoricoCidadaoState extends State<HistoricoCidadao> {
  final CidadaoController cidadaoController = Get.put(CidadaoController());
  final TextEditingController searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _dataInicio;
  DateTime? _dataFim;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime tenDaysAgo = now.subtract(Duration(days: 10));
    _dataInicio = tenDaysAgo;
    _dataFim = now;
    _loadCidadaos();
  }

  Future<void> _loadCidadaos() async {
    await cidadaoController.searchCidadaos(
      query: _searchTerm,
      dataInicio: _dataInicio?.toIso8601String().split('T').first,
      dataFim: _dataFim?.toIso8601String().split('T').first,
      limit: 10,
    );
  }

  void _onSearch(String query) {
    setState(() {
      _searchTerm = query;
    });
    cidadaoController.searchCidadaos(
      query: query,
      dataInicio: _dataInicio?.toIso8601String().split('T').first,
      dataFim: _dataFim?.toIso8601String().split('T').first,
      limit: 10,
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroCidadao(
          name: cidadaoController.listCidadaoObs.map((c) => c.name).toSet().toList(),
          onSave: (filters) {
            setState(() {
              _dataInicio = filters['dataInicio'];
              _dataFim = filters['dataFim'];
            });
            cidadaoController.searchCidadaos(
              query: _searchTerm,
              dataInicio: _dataInicio?.toIso8601String().split('T').first,
              dataFim: _dataFim?.toIso8601String().split('T').first,
              limit: 10,
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
        onRefresh: _loadCidadaos,
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
                  const SizedBox(height: 20),
                  buttonBar(),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _showFilterDialog,
                          child: Container(
                            width: 65,
                            height: 32,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 65,
                                    height: 32,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFCFDDF2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x269FE3FF),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 6.09,
                                  top: 7,
                                  child: Container(
                                    width: 53.91,
                                    height: 18,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 18.91,
                                          top: 2,
                                          child: SizedBox(
                                            width: 35,
                                            height: 13,
                                            child: Text(
                                              'Filtrar',
                                              style: TextStyle(
                                                color: Color(0xFF2F2F2F),
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Icon(
                                            Icons.filter_list,
                                            size: 18,
                                            color: Color(0xFF2F2F2F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 32,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Pesquisar',
                                hintStyle: TextStyle(
                                  color: Color(0xFF979797),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF979797),
                                ),
                              ),
                              onChanged: _onSearch,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    if (cidadaoController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cidadaoController.listCidadaoObs.length,
                        itemBuilder: (context, index) {
                          CidadaoModel cidadao = cidadaoController.listCidadaoObs[index];
                          return CidadaoCard(cidadao: cidadao);
                        },
                      );
                    }
                  }),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget buttonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastroCidadao(),
              ),
            );
          },
          child: Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/imagens/icon-cadastro.png'),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFFBBD8F0),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 2,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/imagens/icon-historico-ativo.png'),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Histórico',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}