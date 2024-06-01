import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:projetoaplicado/app/home/atendimentos/cadastro/foto-camera.dart';
import 'package:projetoaplicado/app/home/atendimentos/cadastro/foto-upload.dart';
import 'package:projetoaplicado/app/home/tela-inicio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/backend/services/cidadaoService.dart';

import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';

import '../pendente/tela-atend-pendente.dart';
import '../historico/tela-atend-historico.dart';

class AtendimentoForms extends StatefulWidget {
  final String? numeroProtocolo;

  AtendimentoForms({Key? key, this.numeroProtocolo}) : super(key: key);
  
  @override
  _AtendimentoFormsState createState() => _AtendimentoFormsState();
}

//Classe para Lista de itens entregues
class Item {
  String name;
  bool isSelected;

  Item({required this.name, this.isSelected = false});
}
class _AtendimentoFormsState extends State<AtendimentoForms> {
  List<AcontecimentoModel> listAcontecimento = [];
  List<CidadaoModel> suggestions = [];
  List<Item> items = [];

  CidadaoService cidadaoService = CidadaoService();

  TextEditingController _cpfResponsavelController = TextEditingController();
  TextEditingController _nomeResponsavelController = TextEditingController();
  AcontecimentoController _acontecimentoController = AcontecimentoController();
  AtendimentoController _atendimentoController = AtendimentoController();
  final CidadaoController cidadaoController = CidadaoController.cidadaoController;

  List<String> _uploadedUrls = [];

  @override
  void initState() {
    super.initState();
    _carregarAcontecimentos();
    if (widget.numeroProtocolo != null) {
      _selectedNumeroProtocoloAtendimento = widget.numeroProtocolo!;
    }
    items = [
      Item(name: 'Água Potável'),
      Item(name: 'Cestas básicas'),
      Item(name: 'Kits'),
      Item(name: 'Pastilha potabilizadora de água'),
      Item(name: 'Colchões'),
      Item(name: 'Lonas'),
      Item(name: 'Cumeeiras'),
      Item(name: 'Pregos/Parafusos'),
      Item(name: 'Telhas'),
      Item(name: 'Reservatórios'),
      Item(name: 'Fraldas'),
    ];
  }

  void _carregarAcontecimentos() async {
    listAcontecimento = await _acontecimentoController.listAcontecimento();
    setState(() {});
  }

  AcontecimentoModel? findAcontecimentoByProtocolo(String numeroProtocolo) {
    return listAcontecimento.firstWhere(
      (acontecimento) => acontecimento.numeroProtocolo == numeroProtocolo,
    );
  }

  List<CidadaoModel> getFilteredCidadaoList(String query, List<CidadaoModel> cidadaoList) {
    if (query.isEmpty) {
      return [];
    }

    List<CidadaoModel> matches = [];

    matches.addAll(cidadaoList);

    return matches;
  }

  List<String> getSelectedItems() {
    return items.where((item) => item.isSelected).map((item) => item.name).toList();
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
        _dataSolicitacaoController.text.isEmpty ||
        _dataVistoriaController.text.isEmpty ||
        _selectedEntregarItens == 'Selecionar') {
      _exibirMensagem('Por favor, preencha todos os campos obrigatórios.');
      return;
    }

    AtendimentosModel novoAtendimento = AtendimentosModel(
      n_protocolo: _selectedNumeroProtocoloAtendimento!,
      tipoAtendimento: _selectedTipoAtendimento,
      canalAtendimento: _selectedCanalAtendimento,
      nomeResponsavel: _cpfResponsavelController.text,
      vistoriaRealizada: _VistoriaRealizadaController,
      tipoVistoria: _selectedTipoRealizada,
      dataSolicitacao: _dataSolicitacaoController.text,
      dataVistoria: _dataVistoriaController.text,
      entregueItensAjuda: _selectedEntregarItens == 'Sim' ? true : false,
      materiaisEntregues: getSelectedItems(),
      observacoes: _observacoesController.text,
      pendente: true,
      imagesUrls: _uploadedUrls, // Sobe as imagens com URL no servidor Firebase
    );

    var resposta = await _atendimentoController.post(novoAtendimento);

    if (resposta != null && resposta.contains('Atendimento criado com sucesso!')) {
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
      _selectedVistoriaRealizada = 'Selecionar';
      _selectedTipoRealizada = 'Selecionar';
      _selectedEntregarItens = 'Selecionar';
      _nomeResponsavelController.clear();
      _cpfResponsavelController.clear();
      _dataSolicitacaoController.clear();
      _dataVistoriaController.clear();
      _observacoesController.clear();
      _VistoriaRealizadaController = false;
      for (var item in items) {
        item.isSelected = false;
      }
      _uploadedUrls.clear(); //Sobe as imagens com URL no servidor Firebase
    });
  }

  List<Widget> buildCheckListTiles() {
    return items.map((item) {
      return CheckboxListTile(
        title: Text(item.name),
        value: item.isSelected,
        onChanged: (bool? newValue) {
          setState(() {
            item.isSelected = newValue ?? false;
          });
        },
      );
    }).toList();
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
                          controller: _nomeResponsavelController, // Este controller agora só para exibir o nome
                          debounceDuration: Duration(milliseconds: 300),
                          suggestionsCallback: (search) async {
                            if (search.isEmpty) {
                              return [];
                            }

                            var cidadaoService = CidadaoService();
                            var cidadaoList = await cidadaoService.fetchListCidadao(searchTerm: search);

                            return getFilteredCidadaoList(search, cidadaoList);
                          },
                          builder: (context, controller, focusNode) {
                            return TextField(
                              controller: _nomeResponsavelController,
                              focusNode: focusNode,
                              autofocus: false,
                              decoration: _customInputDecoration("Nome do responsável no local:"),
                              onChanged: (text) async {
                                if (text.isEmpty) {
                                  SuggestionsController.of<CidadaoModel>(context).suggestions = [];
                                  return;
                                }

                                var cidadaoService = CidadaoService();
                                var cidadaoList = await cidadaoService.fetchListCidadao(searchTerm: text);

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
                          onSelected: (CidadaoModel cidadao) {
                            setState(() {
                              _nomeResponsavelController.text = cidadao.name;
                              _cpfResponsavelController.text = cidadao.cpf;
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
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ExpansionTile(
                              title: Text('Quais itens foram entregues?'),
                              children: buildCheckListTiles(),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        //Campo de texto longo "Observações"
                        TextField(
                          controller: _observacoesController,
                          decoration: _customInputDecoration('Observações'),
                          maxLines: null, // Permite múltiplas linhas
                          keyboardType: TextInputType.multiline,
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
