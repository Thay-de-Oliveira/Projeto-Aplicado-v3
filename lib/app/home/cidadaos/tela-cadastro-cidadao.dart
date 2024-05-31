import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoaplicado/app/home/cidadaos/tela-cidadaos-cadastrados.dart';
import 'package:projetoaplicado/app/home/tela-inicio.dart';
import '../../../backend/models/cidadaoModel.dart';
import '../../../backend/controllers/cidadaoController.dart';
import '../../../backend/controllers/cepController.dart';
import '../../components/globais/barra-superior.dart';
import '../../components/globais/menu-inferior.dart';

class CadastroCidadao extends StatefulWidget {
  @override
  _CadastroCidadaoState createState() => _CadastroCidadaoState();
}

InputDecoration _customInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(fontSize: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.circular(10.0),
    ),
    counter: Offstage(),
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
  final CepController cepControllerInstance = CepController();

  bool _isSaving = false;
  bool _isCpfValid = true;

  void _exibirMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void buscarCep() async {
    String cep = cepController.text;
    if (cep.length == 8) {
      var dadosCep = await cepControllerInstance.buscarCep(cep);
      if (dadosCep != null) {
        setState(() {
          ruaController.text = dadosCep['logradouro'];
          bairroController.text = dadosCep['bairro'];
          cidadeController.text = dadosCep['localidade'];
          estadoController.text = dadosCep['uf'];
        });
      } else {
        _exibirMensagem('CEP não encontrado.');
      }
    }
  }

  void limparCamposEndereco() {
    setState(() {
      ruaController.clear();
      bairroController.clear();
      cidadeController.clear();
      estadoController.clear();
    });
  }

  bool validarCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11) {
      return false;
    }

    if (cpf.split('').every((c) => c == cpf[0])) {
      return false;
    }

    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int primeiroDigitoVerificador = (soma * 10) % 11;
    if (primeiroDigitoVerificador == 10 || primeiroDigitoVerificador == 11) {
      primeiroDigitoVerificador = 0;
    }
    if (int.parse(cpf[9]) != primeiroDigitoVerificador) {
      return false;
    }

    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    int segundoDigitoVerificador = (soma * 10) % 11;
    if (segundoDigitoVerificador == 10 || segundoDigitoVerificador == 11) {
      segundoDigitoVerificador = 0;
    }
    if (int.parse(cpf[10]) != segundoDigitoVerificador) {
      return false;
    }

    return true;
  }

  Future<void> salvarCidadao() async {
    if (nomeController.text.isEmpty ||
        cpfController.text.isEmpty ||
        rgController.text.isEmpty ||
        cepController.text.isEmpty ||
        numeroCasaController.text.isEmpty ||
        bairroController.text.isEmpty ||
        ruaController.text.isEmpty ||
        cidadeController.text.isEmpty ||
        estadoController.text.isEmpty) {
      _exibirMensagem('Por favor, preencha todos os campos.');
      return;
    }

    if (!_isCpfValid) {
      _exibirMensagem('CPF inválido. Por favor, verifique e tente novamente.');
      return;
    }

    setState(() {
      _isSaving = true; // Desativa o botão ao iniciar o salvamento
    });

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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(title: ''),
          ),
        );
      } else {
        _exibirMensagem('Falha ao cadastrar cidadão.');
      }
    } catch (e) {
      print('Erro ao cadastrar cidadão: $e');
      _exibirMensagem('Erro ao cadastrar cidadão. Por favor, tente novamente.');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Widget buttonBar() {
    bool isCadastro = true; // Altere para 'false' quando estiver na tela de Histórico

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Ink(
            decoration: ShapeDecoration(
              color: isCadastro ? Color(0xFFBBD8F0) : Colors.white,
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
                if (!isCadastro) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastroCidadao()));
                }
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
                      child: Image.asset('assets/imagens/icon-cadastro.png'),
                    ),
                    SizedBox(height: 5.0),
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
        GestureDetector(
          child: Ink(
            decoration: ShapeDecoration(
              color: !isCadastro ? Color(0xFFBBD8F0) : Colors.white,
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
                if (isCadastro) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DadosCidadao()));
                }
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
                      child: Image.asset('assets/imagens/icon-historico.png'),
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
    );
  }

  @override
  void initState() {
    super.initState();
    cepController.addListener(() {
      String cep = cepController.text;
      if (cep.length != 8) {
        limparCamposEndereco();
      }
    });
    cpfController.addListener(() {
      String cpf = cpfController.text;
      if (cpf.length != 11) {
        setState(() {
          _isCpfValid = validarCpf(cpf);
        });
      } else {
        setState(() {
          _isCpfValid = true;
        });
      }
    });
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
            flexibleSpace: BarraSuperior(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                buttonBar(), // Substitua a imagem pelo menu
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: nomeController,
                          decoration: _customInputDecoration('Nome completo:'),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextFormField(
                                    controller: cpfController,
                                    decoration: _customInputDecoration('Cadastro de Pessoa Física (CPF):').copyWith(
                                      errorText: _isCpfValid ? null : 'CPF inválido',
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 11,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: Text(
                                      '${cpfController.text.length}/11',
                                      style: TextStyle(
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
                        SizedBox(height: 30),
                        TextFormField(
                          controller: rgController,
                          decoration: _customInputDecoration('Registro Geral (RG):').copyWith(
                            counterText: '',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 7,
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextFormField(
                                    controller: cepController,
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
                                    bottom: 10,
                                    child: Text(
                                      '${cepController.text.length}/8',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: numeroCasaController,
                                decoration: _customInputDecoration('Número da casa:'),
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
                                onPressed: _isSaving
                                    ? null
                                    : () async {
                                        await salvarCidadao();
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF30BD4F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  _isSaving ? 'Salvando...' : 'Salvar',
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
                                  backgroundColor: Color(0xFFEC6F64),
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
