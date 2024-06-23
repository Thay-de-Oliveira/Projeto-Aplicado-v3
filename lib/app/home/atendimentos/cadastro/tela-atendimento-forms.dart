import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:projetoaplicado/app/home/tela-inicio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/controllers/cepController.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:projetoaplicado/backend/controllers/imagensController.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';
import 'package:projetoaplicado/backend/services/cidadaoService.dart';
import 'package:get/get.dart';
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
  final UserController userController = Get.find<UserController>();
  late ImagensController _imagensController;
  List<AcontecimentoModel> listAcontecimento = [];
  List<CidadaoModel> suggestions = [];
  List<Item> items = [];

  CidadaoService cidadaoService = CidadaoService();

  final TextEditingController _cpfResponsavelController = TextEditingController();
  final TextEditingController _cidadaoResponsavelController = TextEditingController();
  final TextEditingController _atendenteResponsavelController = TextEditingController();
  final AcontecimentoController _acontecimentoController = AcontecimentoController();
  final AtendimentoController _atendimentoController = AtendimentoController();
  final CidadaoController cidadaoController = CidadaoController.cidadaoController;
  final TextEditingController _dataSolicitacaoController = TextEditingController();
  final TextEditingController _dataVistoriaController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final CepController _cepControllerInstance = CepController();

  @override
  void initState() {
    super.initState();
    _carregarAcontecimentos();
    _carregarUsuario();
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
    _imagensController = ImagensController(onImageAdded: updateUI);
    _cepController.addListener(() {
      String cep = _cepController.text;
      if (cep.length != 8) {
        limparCamposEndereco();
      }
    });
  }

  void updateUI() {
    setState(() {});
  }

  void _carregarAcontecimentos() async {
    listAcontecimento = await _acontecimentoController.listAcontecimento();
    setState(() {});
  }

  void _carregarUsuario() {
    UserModel? user = userController.currentUser;
    if (user != null) {
      _atendenteResponsavelController.text = user.username;
    }
  }

  AcontecimentoModel? findAcontecimentoByProtocolo(String numeroProtocolo) {
    return listAcontecimento.firstWhere(
      (acontecimento) => acontecimento.numeroProtocolo == numeroProtocolo,
    );
  }

  List<CidadaoModel> getFilteredCidadaoList(
      String query, List<CidadaoModel> cidadaoList) {
    if (query.isEmpty) {
      return [];
    }

    List<CidadaoModel> matches = [];

    matches.addAll(cidadaoList);

    return matches;
  }

  List<String> getSelectedItems() {
    return items
        .where((item) => item.isSelected)
        .map((item) => item.name)
        .toList();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
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
          _dataSolicitacaoController.text.isEmpty ||
          (_selectedVistoriaRealizada == 'Sim' && _dataVistoriaController.text.isEmpty) ||
          _selectedEntregarItens == 'Selecionar') {
        _exibirMensagem('Por favor, preencha todos os campos obrigatórios.');
        return;
      }

      // Mostrar o indicador de carregamento
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text("Salvando..."),
                ],
              ),
            ),
          );
        },
      );

      AtendimentosModel novoAtendimento = AtendimentosModel(
        nProtocolo: _selectedNumeroProtocoloAtendimento!,
        tipoAtendimento: _selectedTipoAtendimento,
        canalAtendimento: _selectedCanalAtendimento,
        cidadaoResponsavel: _cpfResponsavelController.text,
        vistoriaRealizada: _vistoriaRealizadaController,
        tipoVistoria: _selectedTipoRealizada,
        dataSolicitacao: _dataSolicitacaoController.text,
        dataVistoria: _dataVistoriaController.text,
        entregueItensAjuda: _selectedEntregarItens == 'Sim' ? true : false,
        materiaisEntregues: getSelectedItems(),
        observacoes: _observacoesController.text,
        pendente: true,
        imagesUrls: [],
        atendenteResponsavel: _atendenteResponsavelController.text,
        cep: _cepController.text,
        rua: _ruaController.text,
        bairro: _bairroController.text,
        cidade: _cidadeController.text,
        estado: _estadoController.text,
      );

      // Converter os XFiles para Files
      List<File> imageFiles = _imagensController.imageFiles
          .map((xFile) => File(xFile.path))
          .toList();

      var resposta = await _atendimentoController.post(novoAtendimento, imageFiles);

      // Fechar o indicador de carregamento
      Navigator.of(context).pop();

      if (resposta != null && resposta.contains('Atendimento criado com sucesso!')) {
        _exibirMensagem('Atendimento salvo com sucesso!');
        var protocoloAtendimentoSalvo = novoAtendimento.nProtocolo;
        await AcontecimentoController.acontecimentoController.updateAcontecimento(protocoloAtendimentoSalvo, false);
        _limparCamposFormulario();
      } else {
        _exibirMensagem('Erro ao salvar o atendimento. Tente novamente.');
      }
    } catch (error) {
      // Fechar o indicador de carregamento em caso de erro
      Navigator.of(context).pop();
      print(error.toString());
      _exibirMensagem(error.toString());
    }
  }

  void _exibirMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: const Duration(seconds: 3),
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
      _cidadaoResponsavelController.clear();
      _cpfResponsavelController.clear();
      _dataSolicitacaoController.clear();
      _dataVistoriaController.clear();
      _observacoesController.clear();
      _imagensController.clear();
      _vistoriaRealizadaController = false;
      for (var item in items) {
        item.isSelected = false;
      }
      limparCamposEndereco();
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

  Widget _buildAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    controller: _cepController,
                    decoration: _customInputDecoration('CEP:').copyWith(
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    onChanged: (value) {
                      if (value.length == 8) {
                        buscarCep();
                      }
                      setState(() {});
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  Positioned(
                    right: 10,
                    bottom: 5,
                    child: Text(
                      '${_cepController.text.length}/8',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildNonEditableField(_ruaController, 'Rua:'),
        _buildNonEditableField(_bairroController, 'Bairro:'),
        _buildNonEditableField(_cidadeController, 'Cidade:'),
        _buildNonEditableField(_estadoController, 'Estado:'),
      ],
    );
  }

  Widget _buildNonEditableField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: controller,
          decoration: _customInputDecoration(label).copyWith(
            fillColor: Colors.grey[200],
            filled: true,
          ),
          enabled: false,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void buscarCep() async {
    String cep = _cepController.text;
    if (cep.length == 8) {
      var dadosCep = await _cepControllerInstance.buscarCep(cep);
      if (dadosCep != null) {
        setState(() {
          _ruaController.text = dadosCep['logradouro'];
          _bairroController.text = dadosCep['bairro'];
          _cidadeController.text = dadosCep['localidade'];
          _estadoController.text = dadosCep['uf'];
        });
      } else {
        _exibirMensagem('CEP não encontrado.');
      }
    }
  }

  void limparCamposEndereco() {
    setState(() {
      _ruaController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _estadoController.clear();
    });
  }

  String? _selectedNumeroProtocoloAtendimento;
  String _selectedTipoAtendimento = 'Selecionar atendimento';
  String _selectedCanalAtendimento = 'Selecionar canal de atendimento';
  String _selectedVistoriaRealizada = 'Selecionar';
  bool _vistoriaRealizadaController = false;
  String _selectedTipoRealizada = 'Selecionar';
  String? _selectedEntregarItens = 'Selecionar';

  //Lista de itens entregues
  bool mostrarItensEntregues = false;

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
      labelStyle: const TextStyle(fontSize: 16), //Tamanho da fonte dos campos
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), //Borda arredondada
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
        const BorderSide(color: Colors.grey), //Cor da borda quando inativo
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
        const BorderSide(color: Colors.blue), //Cor da borda quando ativo
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _buildImagePreviews() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imagensController.imageFiles.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Image.file(
                              File(_imagensController.imageFiles[index].path)),
                        );
                      },
                    );
                  },
                  child: Image.file(
                    File(_imagensController.imageFiles[index].path),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imagensController.removeImage(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = userController.currentUser;

    return Scaffold(
      appBar: null,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Botão CADASTRO
                      GestureDetector(
                        child: Ink(
                          decoration: ShapeDecoration(
                            //Estilo
                            color: const Color(0xFFBBD8F0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
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
                                  const SizedBox(
                                      height:
                                      5.0), //Espaço entre o ícone e o texto
                                  const Text(
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
                            color: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
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
                                  const SizedBox(
                                      height:
                                      5.0), //Espaço entre o ícone e o texto
                                  const Text(
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
                            color: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
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
                                  const SizedBox(
                                      height:
                                      5.0), //Espaço entre o ícone e o texto
                                  const Text(
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
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Campo "Número do protocolo de acontecimento"
                          TextFormField(
                            controller: TextEditingController(
                                text: _selectedNumeroProtocoloAtendimento),
                            decoration: _customInputDecoration(
                                'Número do protocolo de acontecimento:'),
                            enabled: false,
                          ),

                          const SizedBox(height: 20),

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

                          const SizedBox(height: 20),

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

                          const SizedBox(height: 20),

                          TypeAheadField<CidadaoModel>(
                            controller:
                            _cidadaoResponsavelController, // Este controller agora só para exibir o nome
                            debounceDuration: const Duration(milliseconds: 300),
                            suggestionsCallback: (search) async {
                              if (search.isEmpty) {
                                return [];
                              }

                              var cidadaoService = CidadaoService();
                              var cidadaoList = await cidadaoService
                                  .fetchListCidadao(searchTerm: search);

                              return getFilteredCidadaoList(search, cidadaoList);
                            },
                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: _cidadaoResponsavelController,
                                focusNode: focusNode,
                                autofocus: false,
                                decoration: _customInputDecoration(
                                    "Nome do responsável no local:"),
                                onChanged: (text) async {
                                  if (text.isEmpty) {
                                    SuggestionsController.of<CidadaoModel>(
                                        context)
                                        .suggestions = [];
                                    return;
                                  }

                                  var cidadaoService = CidadaoService();
                                  var cidadaoList = await cidadaoService
                                      .fetchListCidadao(searchTerm: text);

                                  // Filtra a lista com base na consulta
                                  var filteredList =
                                  getFilteredCidadaoList(text, cidadaoList);

                                  // Atualiza as sugestões
                                  SuggestionsController.of<CidadaoModel>(context)
                                      .suggestions = filteredList;
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
                                _cidadaoResponsavelController.text = cidadao.name;
                                _cpfResponsavelController.text = cidadao.cpf;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

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
                                      if (newValue == "Sim") {
                                        _selectedVistoriaRealizada = 'Sim';
                                        _vistoriaRealizadaController = true;
                                      } else {
                                        _selectedVistoriaRealizada = 'Não';
                                        _vistoriaRealizadaController = false;
                                        _selectedTipoRealizada = 'Selecionar';
                                        _dataVistoriaController.clear();
                                      }
                                    });
                                  },
                                  decoration: _customInputDecoration(
                                      'Vistoria realizada?'), 
                                ),
                              ),
                            ],
                          ),

                          Visibility(
                            visible: _selectedVistoriaRealizada == 'Sim',
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedTipoRealizada,
                                        items: tipoVistoriaOptions
                                            .map((String option) {
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
                                            'Tipo de vistoria:'), 
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _selectDate(
                                            context, _dataVistoriaController),
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            controller: _dataVistoriaController,
                                            decoration: _customInputDecoration(
                                                'Data da vistoria:'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          //Campos lado a lado "Datas"
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _selectDate(
                                      context, _dataSolicitacaoController),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: _dataSolicitacaoController,
                                      decoration: _customInputDecoration(
                                          'Data da solicitação:'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Registro da vistoria',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            _imagensController.takePicture();
                                          }), // Ação de abrir câmera atualizada
                                          child: const Icon(Icons.camera_alt),
                                        ),
                                        const SizedBox(width: 16),
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            _imagensController.pickImage();
                                          }), // Ação de abrir galeria atualizada
                                          child: const Icon(Icons.cloud_upload),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              _imagensController.imageFiles.isEmpty
                                  ? Container()
                                  : _buildImagePreviews(),
                            ],
                          ),

                          const SizedBox(height: 20),

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
                                  mostrarItensEntregues = newValue == 'Sim';
                                });
                              }
                            },
                            decoration: _customInputDecoration(
                              'Será entregue itens de assistência humanitária?',
                            ),
                          ),

                          const SizedBox(height: 20),

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
                                title: const Text('Quais itens foram entregues?'),
                                children: buildCheckListTiles(),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          _buildAddressFields(),

                          //Campo de texto longo "Observações"
                          TextField(
                            controller: _observacoesController,
                            decoration: _customInputDecoration('Observações'),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          ),

                          const SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Botão "Salvar"
                                InkWell(
                                  onTap: () {
                                    _salvarAtendimento();
                                  },
                                  child: Container(
                                    width: 65,
                                    height: 28.61,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF30BD4F),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
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

                                const SizedBox(width: 16),

                                // Botão "Cancelar"
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Home(title: ''),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 28.61,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEC6F64),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
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
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
