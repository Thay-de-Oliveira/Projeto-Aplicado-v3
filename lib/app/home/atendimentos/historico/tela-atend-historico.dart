import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/atendimento/atendimento-card.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import '../../../components/globais/barra-pesquisa.dart';
import '../pendente/tela-atend-pendente.dart';
import '../cadastro/tela-atendimento-forms.dart';

class HistoricoAtendimento extends StatefulWidget {
  @override
  _HistoricoAtendimentoState createState() => _HistoricoAtendimentoState();
}

class _HistoricoAtendimentoState extends State<HistoricoAtendimento> {
  final AtendimentoController atendimentoController = Get.put(AtendimentoController());

  @override
  void initState() {
    super.initState();
    _loadAtendimentos();
  }

  Future<void> _loadAtendimentos() async {
    await atendimentoController.listAtendimento();
  }

  void _onSearch(String query) {
    atendimentoController.searchByWord(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadAtendimentos();
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
                        child: buildMenuButton(
                          'Cadastro',
                          'assets/imagens/icon-cadastro-inativo.png',
                          AtendimentoForms(),
                        ),
                      ),
                      GestureDetector(
                        child: buildMenuButton(
                          'Pendente',
                          'assets/imagens/icon-pendente.png',
                          AtendimentoPendente(),
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
                                      builder: (context) => HistoricoAtendimento()));
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
                                        'assets/imagens/icon-historico-ativo.png'),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  SearchFilterBar(
                    onSearch: _onSearch,
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Container(
                      width: 330,
                      child: Obx(() {
                        var historico = atendimentoController.listAtendimentoObs.toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: historico.length,
                          itemBuilder: (context, index) {
                            AtendimentosModel atendimento = historico[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: AtendimentoCard(atendimento: atendimento),
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
