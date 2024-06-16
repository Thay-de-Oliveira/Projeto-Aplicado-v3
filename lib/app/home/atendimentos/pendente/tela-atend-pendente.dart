import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/acontecimento/acontecimento-card.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';

import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/filtro-atendimento.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa-e-filtro.dart';

import '../historico/tela-atend-historico.dart';
import '../cadastro/tela-atendimento-forms.dart';

class AtendimentoPendente extends StatefulWidget {
  @override
  _AtendimentoPendenteState createState() => _AtendimentoPendenteState();
}

class _AtendimentoPendenteState extends State<AtendimentoPendente> {
  final AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());

  @override
  void initState() {
    super.initState();
    _loadAcontecimentos();
  }

  Future<void> _loadAcontecimentos() async {
    await acontecimentoController.listAcontecimento();
  }

  void _onSearch(String query) {
    acontecimentoController.searchByWord(query);
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroAtendimento();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadAcontecimentos();
        },
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AtendimentoForms()));
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
                                    child: Image.asset(
                                        'assets/imagens/icon-cadastro.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AtendimentoPendente()));
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
                                    child: Image.asset(
                                        'assets/imagens/icon-pendente-ativo.png'),
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
                                      builder: (context) =>
                                          HistoricoAtendimento()));
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
                                    child: Image.asset(
                                        'assets/imagens/icon-historico.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Histórico',
                                    style: TextStyle(
                                      fontSize: 16,
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
                                        ),
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
                                          child: Container(
                                            width: 15.23,
                                            height: 18,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [],
                                            ),
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
                              onChanged: (value) {
                                // Lógica de filtragem de atendimentos
                                _onSearch(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Container(
                      width: 330,
                      child: Obx(() {
                        var pendentes = acontecimentoController.listAcontecimentoObs
                            .where((acontecimento) => acontecimento.pendente == true)
                            .toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: pendentes.length,
                          itemBuilder: (context, index) {
                            AcontecimentoModel acontecimento = pendentes[index];
                            return AcontecimentoCard(acontecimento: acontecimento);
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
