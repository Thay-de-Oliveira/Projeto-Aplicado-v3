import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';
import 'package:projetoaplicado/app/components/cidadao/cidadao-card.dart';
import 'package:projetoaplicado/app/components/globais/filtro-cidadao.dart';

import 'package:projetoaplicado/app/home/cidadaos/cadastro/tela-forms-cidadao.dart';
import 'package:projetoaplicado/app/home/tela-inicio.dart';


import '../../../../backend/models/cidadaoModel.dart';
import '../../../../backend/controllers/cidadaoController.dart';
import '../../../../backend/controllers/cepController.dart';


class HistoricoCidadao extends StatefulWidget {
  @override
  _HistoricoCidadaoState createState() => _HistoricoCidadaoState();
}

class _HistoricoCidadaoState extends State<HistoricoCidadao> {
  final CepController cepControllerInstance = CepController();

  bool _isSaving = false;
  bool isCadastro = false; // Controla a tela atual

  void _exibirMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _onSearch(String query) {
    // Implementar a lógica de pesquisa aqui
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FiltroCidadao(
          name: ['Example'], // Aqui você pode passar a lista de nomes necessários
          onSave: (filters) {
            // Implementar lógica para salvar/aplicar os filtros aqui
            print(filters);
          },
        );
      },
    );
  }

  Widget buttonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            if (!isCadastro) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroCidadao(),
                ),
              );
            }
          },
          child: Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              color: isCadastro ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF),
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
          onTap: () {
            if (isCadastro) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoricoCidadao(),
                ),
              );
            }
          },
          child: Container(
            width: 90,
            height: 80,
            decoration: BoxDecoration(
              color: !isCadastro ? Color(0xFFBBD8F0) : Color(0xFFFFFFFF),
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

  @override
  void initState() {
    super.initState();
    isCadastro = false; // Tela de Histórico está aberta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: CustomScrollView(
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
                const SizedBox(height: 30), // Aumentar o espaçamento aqui
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
                      const SizedBox(width: 10), // Adiciona um espaçamento entre o botão e a barra de pesquisa
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
                            onChanged: _onSearch,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CidadaoCard(
                  cidadao: CidadaoModel(
                    name: 'Lucas da Silva',
                    cpf: '12345678901',
                    rg: '1234567',
                    cep: '12345678',
                    rua: 'Rua Jovani de Morais',
                    bairro: 'Efapi',
                    cidade: 'Chapecó',
                    estado: 'SC',
                    numeroCasa: 100,
                    numPessoasNaCasa: 4,
                    telefone: '999999999',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
