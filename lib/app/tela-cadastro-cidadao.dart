import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/tela-relatorios-acontecimento.dart';
import 'package:projetoaplicado/app/tela-relatorios-atendimento.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-inicio.dart';
import 'tela-relat-aconte-detalhes.dart';

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
                          SizedBox(height: 10.0),
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
                          decoration: _customInputDecoration('Nome completo:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          decoration: _customInputDecoration(
                              'Cadastro de Pessoa Física (CPF):'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          decoration:
                              _customInputDecoration('Registro Geral (RG):'),
                        ),

                        SizedBox(height: 30),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: _customInputDecoration('CEP:'),
                              ),
                            ),

                            SizedBox(width: 10),
                            // Espaço entre os campos
                            Expanded(
                              child: TextFormField(
                                decoration:
                                    _customInputDecoration('Número da casa:'),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          decoration: _customInputDecoration('Bairro:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          decoration: _customInputDecoration('Rua:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          decoration: _customInputDecoration('Cidade:'),
                        ),

                        SizedBox(height: 30),

                        TextFormField(
                          decoration: _customInputDecoration('Estado:'),
                        ),

                        SizedBox(height: 20),

                        Align(
                          //SALVAR + CANCELAR
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                      title: '',
                                    )),
                              );
                            },
                            child: Container(
                              width: 160,
                              height: 28.61,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 90,
                                    top: 0,
                                    child: Container(
                                      width: 65,
                                      height: 28.61,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 65,
                                              height: 28.61,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF30BD4F),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 7,
                                            top: 14,
                                            child: SizedBox(
                                              width: 55,
                                              height: 20,
                                              child: Text(
                                                'Salvar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                  letterSpacing: 0.64,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 81,
                                      height: 28.61,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 81,
                                              height: 28.61,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFFEC6F64),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            top: 14,
                                            child: SizedBox(
                                              width: 75,
                                              height: 20,
                                              child: Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                  letterSpacing: 0.64,
                                                ),
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
