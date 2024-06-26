import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoaplicado/app/components/globais/filtro-cidadao.dart';
import 'package:projetoaplicado/app/home/cidadaos/cadastro/tela-forms-cidadao.dart';
import 'package:projetoaplicado/app/home/cidadaos/historico/tela-cidadaos-cadastrados.dart';
import 'package:projetoaplicado/app/home/cidadaos/historico/tela-detalhes-cidadao.dart';
import 'package:projetoaplicado/app/home/tela-inicio.dart';
import '../../../../backend/models/cidadaoModel.dart';
import '../../../../backend/controllers/cidadaoController.dart';
import '../../../../backend/controllers/cepController.dart';
import '../../../components/globais/barra-superior.dart';
import '../../../components/globais/menu-inferior.dart';

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

  Widget buildHistoricoItem(String id, String nome, String ultimoAtendimento, String cobrade) {
    return GestureDetector(
      onTap: () {
        // Direcionar para a tela de detalhes do cidadão
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesCidadao(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              id,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(nome),
            Text(ultimoAtendimento),
            Text(cobrade),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Implementar ação de informações
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesCidadao(),
                    ),
                  );
                },
                child: Text('Informações'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBBD8F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                buildHistoricoItem(
                  'Lucas - 001', //Colocar ID por cidadão?
                  'Nome completo: Lucas da Silva',
                  'CPF: ***.***.***-01',
                  'Bairro: Efapi | Chapecó - SC',
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

// FiltroCidadao Widget
class FiltroCidadao extends StatefulWidget {
  final List<String> name;
  final Function(Map<String, dynamic>) onSave;

  FiltroCidadao({required this.name, required this.onSave});

  @override
  _FiltroCidadaoState createState() => _FiltroCidadaoState();
}

class _FiltroCidadaoState extends State<FiltroCidadao> {
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  selectedDateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(0xFF1B7CB3),
                            onPrimary: Colors.white,
                            onSurface: Color(0xFF1B7CB3),
                            surface: const Color.fromARGB(255, 193, 214, 230),
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF1B7CB3),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  setState(() {});
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: _customInputDecoration(
                      selectedDateRange == null
                          ? 'Selecione período para filtrar (máx 15 dias)'
                          : 'Período: ${selectedDateRange?.start.toIso8601String().split('T').first} - ${selectedDateRange?.end.toIso8601String().split('T').first}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> filters = {
                        'dataInicio': selectedDateRange?.start,
                        'dataFim': selectedDateRange?.end,
                      };
                      widget.onSave(filters);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
