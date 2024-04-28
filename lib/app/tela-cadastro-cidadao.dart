// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../backend/models/cidadaoModel.dart';
import '../backend/controllers/cidadaoController.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';
import 'tela-inicio.dart';

class CadastroCidadao extends StatefulWidget {
  @override
  _CadastroCidadaoState createState() => _CadastroCidadaoState();
}

InputDecoration _customInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(fontSize: 16), //Tamanho da fonte dos campos
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), //Borda arredondada
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), //Cor da borda quando inativo
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue), //Cor da borda quando ativo
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

class _CadastroCidadaoState extends State<CadastroCidadao> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController numeroCasaController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();

  void _exibirMensagem(String mensagem) {
    // Exibe a mensagem para o usuário (pode ser um snackbar, dialog, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void salvarCidadao() async {
    try {
      CidadaoModel novoCidadao = CidadaoModel(
        name: nomeController.text,
        cpf: int.tryParse(cpfController.text) ?? 0,
        rg: int.tryParse(rgController.text) ?? 0,
        cep: cepController.text,
        rua: ruaController.text,
        bairro: bairroController.text,
        cidade: cidadeController.text,
        estado: estadoController.text,
        numeroCasa: int.tryParse(numeroCasaController.text) ?? 0,
      );

      var response = await CidadaoController.cidadaoController.post(novoCidadao);

      if (response != null) {
        _exibirMensagem('Cidadão cadastrado com sucesso!');
      } else {
        _exibirMensagem('Falha ao cadastrar cidadão.');
      }
    } catch (e) {
      print('Erro ao cadastrar cidadão: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        //Permite rolagem da página
        slivers: <Widget>[
          SliverAppBar(
            floating: true, // A barra irá flutuar no topo
            pinned: true, // A barra será fixa no topo
            snap: false, // Não encolherá a barra ao rolar para baixo
            expandedHeight: 50, // Aumente este valor para adicionar mais espaço
            //backgroundColor: Color(0xfff8f7f7),
            flexibleSpace: BarraSuperior(context), //Barra
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Botão ACONTECIMENTO
                    Container(
                      width: 180,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            //Icone
                            width: 30,
                            height: 30,
                            child:
                                Image.asset('assets/imagens/icon-cidadao.png'),
                          ),
                          SizedBox(height: 1.0),
                          Positioned(
                            left: 0,
                            top: 10,
                            child: Text(
                              'Cadastro de Cidadão',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Campo "Nome do responsável no local"
                        TextFormField(
                          controller: nomeController,
                          decoration: _customInputDecoration('Nome completo:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: cpfController,
                          decoration: _customInputDecoration(
                              'Cadastro de Pessoa Física (CPF):'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: rgController,
                          decoration:
                              _customInputDecoration('Registro Geral (RG):'),
                        ),

                        SizedBox(height: 30),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: cepController,
                                decoration: _customInputDecoration('CEP:'),
                              ),
                            ),

                            SizedBox(width: 10),
                            // Espaço entre os campos
                            Expanded(
                              child: TextFormField(
                                controller: numeroCasaController,
                                decoration:
                                    _customInputDecoration('Número da casa:'),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: bairroController,
                          decoration: _customInputDecoration('Bairro:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: ruaController,
                          decoration: _customInputDecoration('Rua:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: cidadeController,
                          decoration: _customInputDecoration('Cidade:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: estadoController,
                          decoration: _customInputDecoration('Estado:'),
                        ),

                        SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  salvarCidadao();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => Home(title: ''),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF30BD4F), // Cor do botão "Salvar"
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Salvar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.64,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => Home(title: ''),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFEC6F64), // Cor do botão "Cancelar"
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.64,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
