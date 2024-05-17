import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:projetoaplicado/app/foto-camera.dart';
import 'package:projetoaplicado/app/foto-upload.dart';
import 'package:projetoaplicado/app/tela-inicio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/backend/services/cidadaoService.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-atend-historico.dart';

class AtendimentoForms extends StatefulWidget {
  final String? numeroProtocolo;

  AtendimentoForms({Key? key, this.numeroProtocolo}) : super(key: key);
  
  @override
  _AtendimentoFormsState createState() => _AtendimentoFormsState();
}

class _AtendimentoFormsState extends State<AtendimentoForms> {
  TextEditingController nomeResponsavelController = TextEditingController();
  List<CidadaoModel> suggestions = [];

  CidadaoService cidadaoService = CidadaoService();
  final CidadaoController cidadaoController = CidadaoController.cidadaoController;
  AcontecimentoController _acontecimentoController = AcontecimentoController();
  AtendimentoController _atendimentoController = AtendimentoController();
  List<AcontecimentoModel> listAcontecimento = [];

  void _carregarAcontecimentos() async {
    listAcontecimento = await _acontecimentoController.listAcontecimento();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _carregarAcontecimentos(); // Chame a função para carregar a lista de acontecimentos
    // Preencher o campo de protocolo se estiver disponível
    if (widget.numeroProtocolo != null) {
      _selectedNumeroProtocoloAtendimento = widget.numeroProtocolo!;
    }
  }

AcontecimentoModel? findAcontecimentoByProtocolo(String numeroProtocolo) {
  return listAcontecimento.firstWhere(
    (acontecimento) => acontecimento.numeroProtocolo == numeroProtocolo,
  );
}

  List<CidadaoModel> getFilteredCidadaoList(String query, List<CidadaoModel> cidadaoList) {
    List<CidadaoModel> matches = [];

    matches.addAll(cidadaoList);

    matches.retainWhere((cidadao) =>
        cidadao.name.toLowerCase().contains(query.toLowerCase()));

    return matches;
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }

  Future<void> _salvarAtendimento() async {
    try {
      if (_selectedNumeroProtocoloAtendimento == null ||
          _selectedTipoAtendimento == 'Selecionar atendimento' ||
          _selectedCanalAtendimento == 'Selecionar canal de atendimento' ||
          _selectedVistoriaRealizada == 'Selecionar' ||
          _selectedTipoRealizada == 'Selecionar' ||
          _dataSolicitacaoController == null ||
          _dataVistoriaController == null ||
          _selectedEntregarItens == 'Selecionar' || 
          _observacoesController == null) {
        _exibirMensagem('Por favor, preencha todos os campos obrigatórios.');
        return;
      }

      AtendimentosModel novoAtendimento = AtendimentosModel(
        n_protocolo: _selectedNumeroProtocoloAtendimento!,
        tipoAtendimento: _selectedTipoAtendimento,
        canalAtendimento: _selectedCanalAtendimento,
        nomeResponsavel: nomeResponsavelController.text,
        vistoriaRealizada: _VistoriaRealizadaController,
        tipoVistoria: _selectedTipoRealizada,
        dataSolicitacao: _dataSolicitacaoController.text,
        dataVistoria: _dataVistoriaController.text,
        entregueItensAjuda: _selectedEntregarItens == 'Sim' ? true : false,
        pendente: true,
      );

      var resposta = await _atendimentoController.post(novoAtendimento);

      if (resposta != null && resposta == 'Atendimento criado com sucesso!') {
        _exibirMensagem('Atendimento salvo com sucesso!');
        var protocoloAtendimentoSalvo = novoAtendimento.n_protocolo;
        await AcontecimentoController.acontecimentoController.updateAcontecimento(protocoloAtendimentoSalvo, false);
        _limparCamposFormulario();
      } else {
        _exibirMensagem('Erro ao salvar o atendimento. Tente novamente.');
      }
    } catch (error) {
      print(error.toString());
      _exibirMensagem(error.toString());
    }
  }

  void _exibirMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _limparCamposFormulario() {
    setState(() {
      _selectedNumeroProtocoloAtendimento = null;
      _selectedTipoAtendimento = 'Selecionar atendimento';
      _selectedCanalAtendimento = 'Selecionar canal de atendimento';
      // ... Limpar outros campos conforme necessário ...
    });
  }

  String? _selectedNumeroProtocoloAtendimento;
  String _selectedTipoAtendimento = 'Selecionar atendimento';
  String _selectedCanalAtendimento = 'Selecionar canal de atendimento';
  String _selectedVistoriaRealizada = 'Selecionar';
  bool _VistoriaRealizadaController = false;
  String _selectedTipoRealizada = 'Selecionar';
  String? _selectedEntregarItens = 'Selecionar';
  TextEditingController _dataSolicitacaoController = TextEditingController();
  TextEditingController _dataVistoriaController = TextEditingController();
  TextEditingController _observacoesController = TextEditingController();

  bool isAguaSelected = false;
  bool isCestasSelected = false;
  bool isKitsSelected = false;
  bool isPastilhaSelected = false;
  bool isColchaoSelected = false;
  bool isLonaSelected = false;
  bool isCumeeiraSelected = false;
  bool isPregoParafusoSelected = false;
  bool isTelhaSelected = false;
  bool isReservatorioSelected = false;
  bool isFraldaSelected = false;

  //Lista de itens entregues
  bool mostrarItensEntregues = true;

  List<String> tipoAtendimentoOptions = [
    'Selecionar atendimento',
    'Presencial - Chapecó',
    'Presencial - Regional',
    'Presencial - Estadual',
    'Remoto',
    'Outros'
  ];
  List<String> canalAtendimentoOptions = [
    'Selecionar canal de atendimento',
    'Polícia Militar - 190',
    'Bombeiros -193',
    'Polícia Civil - 197',
    'Defesa Civil - 199',
    'Outros'
  ];
  List<String> vistoriaRealizadaOptions = ['Selecionar', 'Sim', 'Não'];
  List<String> tipoVistoriaOptions = ['Selecionar', 'Presencial', 'Remoto'];
  List<String> entragarItensOptions = ['Selecionar', 'Sim', 'Não'];

  InputDecoration _customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 16), //Tamanho da fonte dos campos
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), //Borda arredondada
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.grey), //Cor da borda quando inativo
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue), //Cor da borda quando ativo
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 50,
            flexibleSpace: BarraSuperior(context), //Barra
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Botão CADASTRO
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xFFBBD8F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
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
                                    builder: (context) => AtendimentoForms()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-cadastro.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Cadastro',
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

                    //Botão PENDENTE
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AtendimentoPendente()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-pendente.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Pendente',
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

                    //Botão HISTÓRICO
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
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
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-historico.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
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
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Campo "Número do protocolo de acontecimento"
                        DropdownButtonFormField<String>(
                          value: _selectedNumeroProtocoloAtendimento,
                          items: listAcontecimento.map((AcontecimentoModel acontecimento) {
                            return DropdownMenuItem<String>(
                              value: acontecimento.numeroProtocolo,
                              child: Text(acontecimento.numeroProtocolo.toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            _selectedNumeroProtocoloAtendimento = newValue!;
                          },
                          decoration: _customInputDecoration(
                            'Número do protocolo de acontecimento:'
                          ),
                        ),

                        SizedBox(height: 30),

                        //Campo "Tipo de atendimento"
                        DropdownButtonFormField<String>(
                          value: _selectedTipoAtendimento,
                          items: tipoAtendimentoOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            _selectedTipoAtendimento = newValue!;
                          },
                          decoration:
                              _customInputDecoration('Tipo de atendimento:'),
                        ),

                        SizedBox(height: 30),

                        //Campo "Canal da solicitação"
                        DropdownButtonFormField<String>(
                          value: _selectedCanalAtendimento,
                          items: canalAtendimentoOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            _selectedCanalAtendimento = newValue!;
                          },
                          decoration: _customInputDecoration(
                              'Canal da solicitação:'), // Aplicar estilo personalizado
                        ),

                        SizedBox(height: 30),

                        TypeAheadField<CidadaoModel>(

                          controller: nomeResponsavelController,
                          debounceDuration: Duration(milliseconds: 300),
                          // Função que será chamada conforme você digita
                          suggestionsCallback: (search) async {
                            // Chamada ao seu serviço para buscar cidadãos
                            var cidadaoService = CidadaoService();
                            var cidadaoList = await cidadaoService.fetchListCidadao(searchTerm: search.isNotEmpty ? search : '.');

                            // Filtra a lista com base na consulta
                            return getFilteredCidadaoList(search, cidadaoList);
                          },

                          builder: (context, controller, focusNode) {
                            return TextField(
                              controller: nomeResponsavelController,
                              focusNode: focusNode,
                              autofocus: true,
                              decoration: _customInputDecoration("Nome do responsável no local:"),
                              onChanged: (text) async {
                                // Chamada ao seu serviço para buscar cidadãos quando o texto é alterado
                                var cidadaoService = CidadaoService();
                                var cidadaoList = await cidadaoService.fetchListCidadao(searchTerm: text.isNotEmpty ? text : '.');

                                // Filtra a lista com base na consulta
                                var filteredList = getFilteredCidadaoList(text, cidadaoList);

                                // Atualiza as sugestões
                                SuggestionsController.of<CidadaoModel>(context).suggestions = filteredList;
                              },
                            );
                          },
                          itemBuilder: (context, cidadao) {
                            return ListTile(
                              title: Text(cidadao.name),
                              subtitle: Text('CPF: ${cidadao.cpf}'),
                            );
                          },
                          onSelected: (cidadao) {
                            setState(() {
                              nomeResponsavelController.text = cidadao.name;
                            });
                          },
                        ),

                        SizedBox(height: 30),

                          //Campos lado a lado "Vistoria"
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedVistoriaRealizada,
                                  items: vistoriaRealizadaOptions
                                      .map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      if(newValue == "Sim"){
                                        _selectedVistoriaRealizada = 'Sim';
                                        _VistoriaRealizadaController = true;
                                      } else {
                                        _selectedVistoriaRealizada = 'Não';
                                        _VistoriaRealizadaController = false;
                                      }
                                    });
                                  },
                                  decoration: _customInputDecoration(
                                      'Vistoria realizada?'), // Aplicar estilo personalizado
                                ),
                              ),
                              SizedBox(width: 16), // Espaçamento entre os campos
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedTipoRealizada,
                                  items: tipoVistoriaOptions.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedTipoRealizada = newValue!;
                                    });
                                  },
                                  decoration: _customInputDecoration(
                                      'Tipo de vistoria:'), // Aplicar estilo personalizado
                                ),
                              ),
                            ],
                          ),

                        SizedBox(height: 30),

                        //Campos lado a lado "Datas"
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectDate(context, _dataSolicitacaoController),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _dataSolicitacaoController,
                                    decoration: _customInputDecoration('Data da solicitação:'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectDate(context, _dataVistoriaController),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _dataVistoriaController,
                                    decoration: _customInputDecoration('Data da vistoria:'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        //Campo com icones "Registro da vistoria"
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Registro da vistoria',
                            labelStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .grey), // Cor da borda quando inativo
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Colors.blue), // Cor da borda quando ativo
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Row(
                                // Ícones
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Camera(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: Icon(Icons.camera_alt),
                                    ),
                                  ),
                                  SizedBox(width: 16), // Espaçamento entre os ícones
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Upload(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: Icon(Icons.cloud_upload),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        //Campo "Será entregue itens de assistencia humanitaria"
                        DropdownButtonFormField<String>(
                          value: _selectedEntregarItens,
                          items: entragarItensOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (entragarItensOptions.contains(newValue)) {
                              setState(() {
                                _selectedEntregarItens = newValue;
                              });
                            } else {
                              // Trate isso de acordo com a lógica desejada, por exemplo, defina um valor padrão
                              print("Valor inválido selecionado: $newValue");
                              
                              // Defina um valor padrão ou tome outra ação adequada
                              setState(() {
                                _selectedEntregarItens = entragarItensOptions.first;
                              });
                            }
                          },
                          decoration: _customInputDecoration(
                            'Será entregue itens de assistência humanitária?',
                          ),
                        ),

                        SizedBox(height: 30),

                        //Campo CHECKLIST "Quais itens foram entregues?"
                        Visibility(
                          visible: mostrarItensEntregues,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Colors.grey), // Cor da borda quando inativo
                              borderRadius: BorderRadius.circular(
                                  10.0), // Borda arredondada
                            ),
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Text(
                                    'Quais itens foram entregues?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              trailing:
                                  Icon(Icons.arrow_drop_down), //Ícone de seta
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CheckboxListTile(
                                        title: Text('Água Potável'),
                                        value: isAguaSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isAguaSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Cestas básicas'),
                                        value: isCestasSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isCestasSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Kits'),
                                        value: isKitsSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isKitsSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text(
                                            'Pastilha potabilizadora de água'),
                                        value: isPastilhaSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isPastilhaSelected =
                                                newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Colchões'),
                                        value: isColchaoSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isColchaoSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Lonas'),
                                        value: isLonaSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isLonaSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Cumeeiras'),
                                        value: isCumeeiraSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isCumeeiraSelected =
                                                newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Pregos/Parafusos'),
                                        value: isPregoParafusoSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isPregoParafusoSelected =
                                                newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Telhas'),
                                        value: isTelhaSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isTelhaSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Reservatórios'),
                                        value: isReservatorioSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isReservatorioSelected =
                                                newValue ?? false;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Fraldas'),
                                        value: isFraldaSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isFraldaSelected = newValue ?? false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        //Campo de texto longo "Observações"
                        TextField(
                          decoration: _customInputDecoration('Observações'),
                          maxLines: null, // Permite múltiplas linhas
                          keyboardType: TextInputType
                              .multiline, // Define o teclado como multilinha
                          onChanged: (String value) {
                            // Aqui você pode atualizar o estado com o valor do campo de observação
                            // Exemplo: _observacoes = value;
                          },
                        ),

                        SizedBox(height: 20),

                        Align(
                          // SALVAR + CANCELAR
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Botão "Salvar"
                              InkWell(
                                onTap: () {
                                  _salvarAtendimento();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AtendimentoForms()));
                                },
                                child: Container(
                                  width: 65,
                                  height: 28.61,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF30BD4F),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
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
                              ),

                              SizedBox(width: 16), // Espaçamento entre os botões

                              // Botão "Cancelar"
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => Home(title: ''),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 75,
                                  height: 28.61,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEC6F64),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
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
                              ),
                            ],
                          ),
                        ),

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
