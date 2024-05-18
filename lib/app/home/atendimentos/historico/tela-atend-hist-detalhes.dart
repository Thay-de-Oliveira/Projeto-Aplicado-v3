// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace
import 'package:get/get.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/components/acontecimento/acontecimento-card.dart';

import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';

import '../pendente/tela-atend-pendente.dart';
import '../cadastro/tela-atendimento-forms.dart';
import 'tela-atend-historico.dart';

import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';

class DetalheHistorico extends StatefulWidget {
  final AtendimentosModel atendimento;

  //final AcontecimentoModel acontecimento;

  const DetalheHistorico({Key? key, required this.atendimento})
      : super(key: key);

  @override
  _DetalheHistorico createState() => _DetalheHistorico();
}

class _DetalheHistorico extends State<DetalheHistorico> {
  @override
  AtendimentoController atendimentoController = Get.put(AtendimentoController());
  AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());

  bool isPendente = false;
  void initState() {
    super.initState();
    isPendente = widget.atendimento.pendente;
    _loadAcontecimento();
  }

  Future<void> _loadAcontecimento() async {
    try {
      AcontecimentoModel acontecimento = await acontecimentoController
          .getAcontecimentoByProtocolo(widget.atendimento.n_protocolo);
      setState(() {
        _acontecimento = acontecimento;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  AcontecimentoModel? _acontecimento;
  String? _errorMessage;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              //Permite descer na tela
              child: Container(
            width: 360,
            height: 1510,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                //DADOS DA OCORRENCIA
                Positioned(
                  left: 11,
                  top: 175,
                  child: Container(
                    width: 338,
                    height: 866,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 331,
                            height: 16,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: SizedBox(
                                    width: 130,
                                    height: 16,
                                    child: Text(
                                      'Dados da ocorrência',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
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
                          top: 27,
                          child: Container(
                            width: 338,
                            height: 839,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 338,
                                    height: 845,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x3F2F2F2F),
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 56,
                                  top: 238,
                                  child: SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'N° do Protocolo: ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              height: 1.2,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' ${widget.atendimento.n_protocolo}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 13,
                                  top: 231,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFCFDDF2),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 13,
                                  top: 15,
                                  child: Container(
                                    width: 313,
                                    height: 240,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: SizedBox(
                                            width: 130,
                                            height: 18,
                                            child: Text(
                                              'Acontecimento',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 30,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFCFDDF2),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 36,
                                          child: SizedBox(
                                            width: 200,
                                            height: 30,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Subgrupo: ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' ${_acontecimento!.subgrupo}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 83,
                                          child: SizedBox(
                                            width: 226,
                                            height: 16,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Tipo:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${_acontecimento!.tipo}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 76,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFCFDDF2),
                                                      shape: OvalBorder(),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  //TIPO
                                                  left: 25,
                                                  top: 5,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(1.57),
                                                    child: Container(
                                                      //Icone
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                          'assets/imagens/icon-tipo.png'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 122,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFCFDDF2),
                                                      shape: OvalBorder(),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 4.50,
                                                  top: 4.12,
                                                  child: Container(
                                                    width: 20.62,
                                                    height: 20.62,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(),
                                                    child: Stack(children: []),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 122,
                                          child: SizedBox(
                                            width: 270,
                                            height: 31,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Evento:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${_acontecimento!.tipo}'
                                                        ' ${_acontecimento!.subtipo}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 176,
                                          child: SizedBox(
                                            width: 130,
                                            height: 16,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'COBRADE:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${_acontecimento!.infoCobrade}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 169,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFCFDDF2),
                                                      shape: OvalBorder(),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  //COBRADE
                                                  left: 5,
                                                  top: 5,
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-cobrade.png'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //SUBGRUPO
                                          left: 5,
                                          top: 55,
                                          child: Transform(
                                            transform: Matrix4.identity()
                                              ..translate(0.0, 0.0)
                                              ..rotateZ(-1.57),
                                            child: Container(
                                              //Icone
                                              width: 20,
                                              height: 20,
                                              child: Image.asset(
                                                  'assets/imagens/icon-subgrupo.png'),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //N. PROTOCOLO
                                          left: 6,
                                          top: 222,
                                          child: Container(
                                            //Icone
                                            width: 18,
                                            height: 18,
                                            child: Image.asset(
                                                'assets/imagens/icon-numero-protocolo.png'),
                                          ),
                                        ),
                                        Positioned(
                                          //EVENTO
                                          left: 5,
                                          top: 127,
                                          child: Container(
                                            //Icone
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                                'assets/imagens/icon-evento.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 13,
                                  top: 570,
                                  child: Container(
                                    width: 350,
                                    height: 244,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: SizedBox(
                                            width: 120,
                                            height: 15,
                                            child: Text(
                                              'Atendimento',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 216,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFF8BD69C),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 42,
                                          top: 177,
                                          child: SizedBox(
                                            width: 244,
                                            height: 15,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Ocorrência: ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Precisa adicionar',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 217,
                                          child: SizedBox(
                                            width: 270,
                                            height: 32,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Endereço:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' Precisa adicionar',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 170,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFF8BD69C),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 39,
                                          child: SizedBox(
                                            width: 220,
                                            height: 16,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Nome do atendente:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' Implementar do login',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 32,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFF8BD69C),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 85,
                                          child: SizedBox(
                                            width: 196,
                                            height: 16,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Código de identificação:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' implementar do login',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 78,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFF8BD69C),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //CÓDIGO DE IDENTIFICAÇÃO
                                          left: 5,
                                          top: 83,
                                          child: Container(
                                            //Icone
                                            width: 18,
                                            height: 18,
                                            child: Image.asset(
                                                'assets/imagens/icon-cod.png'),
                                          ),
                                        ),
                                        Positioned(
                                          left: 43,
                                          top: 131,
                                          child: SizedBox(
                                            width: 214,
                                            height: 16,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Data da vistoria:',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${widget.atendimento.dataVistoria}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 124,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFF8BD69C),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //DATA VISTORIA
                                          left: 6,
                                          top: 130,
                                          child: Container(
                                            //Icone
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                                'assets/imagens/icon-data-vistoria.png'),
                                          ),
                                        ),
                                        Positioned(
                                          //NOME ATENDENTE
                                          left: 7,
                                          top: 38,
                                          child: Container(
                                            //Icone
                                            width: 16,
                                            height: 16,
                                            child: Image.asset(
                                                'assets/imagens/icon-atendente-nome.png'),
                                          ),
                                        ),
                                        Positioned(
                                          //OCORRENCIA
                                          left: 7,
                                          top: 177,
                                          child: Container(
                                            //Icone
                                            width: 16,
                                            height: 16,
                                            child: Image.asset(
                                                'assets/imagens/icon-ocorrencia.png'),
                                          ),
                                        ),
                                        Positioned(
                                          //ENDEREÇO
                                          left: 6,
                                          top: 220,
                                          child: Container(
                                            //Icone
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                                'assets/imagens/icon-endereco.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 13,
                                  top: 300,
                                  child: Container(
                                    width: 290,
                                    height: 244,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 5,
                                          child: SizedBox(
                                            width: 120,
                                            height: 15,
                                            child: Text(
                                              'Família/Cidadãos',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 30,
                                          child: Container(
                                            width: 290,
                                            height: 214,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 43,
                                                  top: 53,
                                                  child: SizedBox(
                                                    width: 229,
                                                    height: 16,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'CPF do solicitante:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' 123456789-10',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 46,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: Color(
                                                                  0xFFF08C86),
                                                              shape:
                                                                  OvalBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 5,
                                                          top: 5,
                                                          child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  //CPF
                                                                  left: 0,
                                                                  top: 0,
                                                                  child:
                                                                      Container(
                                                                    //Icone
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/imagens/icon-cpf.png'),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 3,
                                                                  top: 10,
                                                                  child:
                                                                      Container(
                                                                    width: 14,
                                                                    height: 5,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                Color(0xFFF08C86)),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 6,
                                                                  top: 10,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 8,
                                                                    height: 5,
                                                                    child: Text(
                                                                      'CPF',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            4,
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
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
                                                Positioned(
                                                  left: 43,
                                                  top: 145,
                                                  child: SizedBox(
                                                    width: 247,
                                                    height: 16,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Telefone do solicitante:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' 49 98888-0888',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 138,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: Color(
                                                                  0xFFF08C86),
                                                              shape:
                                                                  OvalBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          //TELEFONE
                                                          left: 7,
                                                          top: 5,
                                                          child: Container(
                                                            //Icone
                                                            width: 20,
                                                            height: 20,
                                                            child: Image.asset(
                                                                'assets/imagens/icon-telefone.png'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 43,
                                                  top: 191,
                                                  child: SizedBox(
                                                    width: 214,
                                                    height: 18,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Número de pessoas no imóvel:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' 03',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 184,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFF08C86),
                                                      shape: OvalBorder(),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 43,
                                                  top: 7,
                                                  child: SizedBox(
                                                    width: 223,
                                                    height: 16,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Nome do solicitante:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' Lucas da Silva',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: Color(
                                                                  0xFFF08C86),
                                                              shape:
                                                                  OvalBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          //NOME SOLICITANTE
                                                          left: 5,
                                                          top: 5,
                                                          child: Container(
                                                            //Icone
                                                            width: 20,
                                                            height: 20,
                                                            child: Image.asset(
                                                                'assets/imagens/icon-nome-solicitante.png'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 43,
                                                  top: 96,
                                                  child: SizedBox(
                                                    width: 229,
                                                    height: 16,
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'RG do solicitante:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' 01234567891',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  top: 92,
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: Color(
                                                                  0xFFF08C86),
                                                              shape:
                                                                  OvalBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 5,
                                                          top: 5,
                                                          child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  //RG SOLICITANTE
                                                                  left: 0,
                                                                  top: 0,
                                                                  child:
                                                                      Container(
                                                                    //Icone
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/imagens/icon-rg.png'),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 3,
                                                                  top: 10,
                                                                  child:
                                                                      Container(
                                                                    width: 14,
                                                                    height: 5,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                Color(0xFFF08C86)),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 7,
                                                                  top: 10,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 6,
                                                                    height: 5,
                                                                    child: Text(
                                                                      'RG',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            4,
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        height:
                                                                            0,
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
                                                Positioned(
                                                  //NUMERO PESSOAS NO IMOVEL
                                                  left: 6,
                                                  top: 190,
                                                  child: Container(
                                                    //Icone
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                        'assets/imagens/icon-pessoas-imovel.png'),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //DOCUMENTOS >> DONWLOADS
                Positioned(
                  left: 11,
                  top: 70,
                  child: Container(
                    width: 338,
                    height: 88,
                    child: Stack(
                      children: [
                        Container(
                          width: 338,
                          height: 88,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 232,
                                top: 25,
                                child: Container(
                                  width: 106,
                                  height: 63,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 106,
                                          height: 63,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F2F2F2F),
                                                blurRadius: 1,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 30,
                                        child: SizedBox(
                                          width: 86,
                                          height: 9,
                                          child: Text(
                                            'Emitido em 09/05/2023',
                                            style: TextStyle(
                                              color: Color(0xFF6C6C6C),
                                              fontSize: 8,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 41,
                                        child: Container(
                                          width: 86,
                                          height: 16,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 86,
                                                  height: 16,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF7CA0FF),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 7,
                                                top: -8,
                                                child: Container(
                                                  //Icone
                                                  width: 30,
                                                  height: 30,
                                                  child: Image.asset(
                                                      'assets/imagens/icon-donwload.png'),
                                                ),
                                              ),
                                              Positioned(
                                                left: 31,
                                                top: 8,
                                                child: SizedBox(
                                                  width: 41,
                                                  height: 10,
                                                  child: Text(
                                                    'Donwload',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 9,
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 31,
                                        top: 12,
                                        child: SizedBox(
                                          width: 45,
                                          height: 12,
                                          child: Text(
                                            'Recibo',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 116,
                                top: 25,
                                child: Container(
                                  width: 106,
                                  height: 63,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 106,
                                          height: 63,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F2F2F2F),
                                                blurRadius: 1,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 30,
                                        child: SizedBox(
                                          width: 86,
                                          height: 9,
                                          child: Text(
                                            'Emitido em 09/05/2023',
                                            style: TextStyle(
                                              color: Color(0xFF6C6C6C),
                                              fontSize: 8,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 41,
                                        child: Container(
                                          width: 86,
                                          height: 16,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 86,
                                                  height: 16,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF7CA0FF),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 7,
                                                top: -8,
                                                child: Container(
                                                  //Icone
                                                  width: 30,
                                                  height: 30,
                                                  child: Image.asset(
                                                      'assets/imagens/icon-donwload.png'),
                                                ),
                                              ),
                                              Positioned(
                                                left: 31,
                                                top: 8,
                                                child: SizedBox(
                                                  width: 41,
                                                  height: 10,
                                                  child: Text(
                                                    'Donwload',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 9,
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 31,
                                        top: 12,
                                        child: SizedBox(
                                          width: 45,
                                          height: 12,
                                          child: Text(
                                            'Relatório',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
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
                                child: SizedBox(
                                  width: 80,
                                  height: 16,
                                  child: Text(
                                    'Documentos',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Positioned(
                                left: 0,
                                top: 25,
                                child: Container(
                                  width: 106,
                                  height: 63,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 106,
                                          height: 63,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F2F2F2F),
                                                blurRadius: 1,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 26,
                                        top: 12,
                                        child: SizedBox(
                                          width: 54,
                                          height: 12,
                                          child: Text(
                                            'Ocorrência',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 30,
                                        child: SizedBox(
                                          width: 86,
                                          height: 9,
                                          child: Text(
                                            'Emitido em 09/05/2023',
                                            style: TextStyle(
                                              color: Color(0xFF6C6C6C),
                                              fontSize: 8,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 41,
                                        child: Container(
                                          width: 86,
                                          height: 16,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 86,
                                                  height: 16,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF7CA0FF),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 7,
                                                top: -8,
                                                child: Container(
                                                  //Icone
                                                  width: 30,
                                                  height: 30,
                                                  child: Image.asset(
                                                      'assets/imagens/icon-donwload.png'),
                                                ),
                                              ),
                                              Positioned(
                                                left: 31,
                                                top: 8,
                                                child: SizedBox(
                                                  width: 41,
                                                  height: 10,
                                                  child: Text(
                                                    'Donwload',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 9,
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //
                Positioned(
                  left: 10.99,
                  top: 490,
                  child: Container(
                    width: 338.02,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 11,
                  top: 760,
                  child: Container(
                    width: 338.02,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 11,
                  top: 1331,
                  child: Container(
                    width: 338,
                    height: 94,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 331,
                            height: 16.08,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: SizedBox(
                                    width: 130,
                                    height: 16,
                                    child: Text(
                                      'Assinaturas',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
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
                          top: 31,
                          child: Container(
                            width: 165,
                            height: 63,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 165,
                                    height: 63,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x3F2F2F2F),
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  top: 44,
                                  child: Container(
                                    width: 136,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.50,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 32,
                                  top: 53,
                                  child: SizedBox(
                                    width: 110,
                                    height: 10,
                                    child: Text(
                                      'Agente da Defesa Civil',
                                      style: TextStyle(
                                        color: Color(0xFF696262),
                                        fontSize: 10,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 173,
                          top: 31,
                          child: Container(
                            width: 165,
                            height: 63,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 165,
                                    height: 63,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x3F2F2F2F),
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  top: 44,
                                  child: Container(
                                    width: 136,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.50,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 56,
                                  top: 53,
                                  child: SizedBox(
                                    width: 53,
                                    height: 10,
                                    child: Text(
                                      'Beneficiado',
                                      style: TextStyle(
                                        color: Color(0xFF696262),
                                        fontSize: 10,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
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

                //Teste1
                //Carrossel
                Positioned(
                  left: 10,
                  top: 1070,
                  child: Container(
                    width: 338,
                    height: 214,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 01,
                          top: 03,
                          child: Container(
                            width: 331,
                            height: 16,
                            child: Stack(
                              children: [
                                Positioned(
                                  //Titulo
                                  left: 0,
                                  top: 0,
                                  child: SizedBox(
                                    width: 130,
                                    height: 16,
                                    child: Text(
                                      'Registro fotográfico',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Fotos
                        Positioned(
                          left: 10,
                          top: 30,
                          child: Container(
                            width: 338,
                            height: 182,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 182,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                              items: [
                                'assets/imagens/imagem-1.png',
                                'assets/imagens/imagem-2.png',
                                'assets/imagens/imagem-3.png',
                                'assets/imagens/imagem-4.png',
                              ].map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Image.network(
                                        item,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 360,
                    height: 57,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 360,
                            height: 57,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 360,
                                    height: 57,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(1.00, -0.03),
                                        end: Alignment(-1, 0.03),
                                        colors: [
                                          Color(0xFF1A7CB2),
                                          Color(0xFF4BA1E0)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 283,
                                  top: 18,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(children: []),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 158,
                          top: 8,
                          child: Container(
                            //Icone
                            width: 20,
                            height: 20,
                            child:
                                Image.asset('assets/imagens/icon-subtipo.png'),
                          ),
                        ),
                        Positioned(
                          left: 315,
                          top: 18.27,
                          child: Container(
                            width: 20,
                            height: 20.30,
                            child: Stack(children: []),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: BarraSuperior(context),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
