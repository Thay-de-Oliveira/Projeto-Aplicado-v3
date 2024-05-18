import 'package:flutter/material.dart';
import 'package:projetoaplicado/app/app-state.dart';
import 'package:projetoaplicado/app/home/atendimentos/cadastro/tela-atendimento-forms.dart';
import 'package:projetoaplicado/app/tela-inicio.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:provider/provider.dart';

import '../../components/globais/barra-superior.dart';
import '../../components/globais/menu-inferior.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AcontecimentosForms(),
    );
  }
}

class AcontecimentosForms extends StatefulWidget {
  @override
  _FormularioAcontecimentoState createState() =>
      _FormularioAcontecimentoState();
}

class _FormularioAcontecimentoState extends State<AcontecimentosForms> {
  final AcontecimentoController _acontecimentoController = AcontecimentoController();

  String? _selectedClasseAcontecimento;
  String? _selectedGrupo;
  String? _selectedSubGrupo;
  String? _selectedTipo;
  String? _selectedSubTipo;
  String? _selectedCobradeAutomatico;

  final DateTime dataAtual = DateTime.now();

  InputDecoration _customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.all(10.0),
    );
  }

  Future<String?> _salvar() async {
    if (_selectedClasseAcontecimento == null ||
        _selectedGrupo == null ||
        _selectedSubGrupo == null ||
        _selectedTipo == null ||
        _selectedSubTipo == null ||
        _selectedCobradeAutomatico == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
      return null;
    }

    AcontecimentoModel acontecimento = AcontecimentoModel(
      classe: _selectedClasseAcontecimento!,
      grupo: _selectedGrupo!,
      subgrupo: _selectedSubGrupo!,
      tipo: _selectedTipo!,
      subtipo: _selectedSubTipo!,
      infoCobrade: _selectedCobradeAutomatico!,
      dataHora: DateTime.now(),
      pendente: true,
    );

    var response = await _acontecimentoController.post(acontecimento);

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acontecimento criado com sucesso.'),
        ),
      );
      return 'Acontecimento criado com sucesso.';
    } else {
      return 'Erro ao criar acontecimento. Por favor contate o suporte.';
    }
  }


  // Opções para a classe de acontecimento
  List<String> classeOptions = [
    'Natural',
    'Tecnológica',
    'Vistoria',
  ];

  // Opções para o grupo (dependente da classe de acontecimento)
  Map<String, List<String>> grupoOptions = {
    'Natural': [
      'Geológico',
      'Hidrológico',
      'Metereológico',
      'Climatológico',
      'Biológico'
    ],
    'Tecnológica': [
      'Substâncias Radioativos',
      'Produtos Perigosos',
      'Incêndios Urbanos',
      'Obras Civis',
      'Passageiros e Cargas não Perigosas'
    ],
    'Vistoria': ['Primeira Vistoria', 'Segunda Vistoria'],
  };

  // Opções para o subgrupo (dependente do grupo)
  Map<String, List<String>> subGrupoOptions = {
    'Geológico': [
      'Terremoto',
      'Emanação Vulcânica',
      'Movimento de Massa',
      'Erosão'
    ],
    'Hidrológico': ['Inudação', 'Enxurrada', 'Alagamento'],
    'Metereológico': [
      'Sistema de Grande Escala',
      'Tempestades',
      'Temperaturas Extremas'
    ],
    'Climatológico': ['Seca'],
    'Biológico': ['Epidemias', 'Infestação/Pragas'],
    'Substâncias Radioativos': [
      'Desastres Siderais',
      'Equipamentos Radioativos',
      'Poluíção Radioativa'
    ],
    'Produtos Perigosos': [
      'Extravasamento de Produtos',
      'Contaminação de Água',
      'Conflitos Bélicos',
      'Transporte de Produtos'
    ],
    'Incêndios Urbanos': ['Incêndios Urbanos'],
    'Obras Civis': ['Colapso de Edificações', 'Colapso de Barragens'],
    'Passageiros e Cargas não Perigosas': [
      'Trasnporte Rodoviário',
      'Transporte Ferroviário',
      'Transporte Aéreo',
      'Transporte Marítimo',
      'Transporte Aquaviário'
    ],
    'Primeira Vistoria': ['Vistoria Solicitada'],
    'Segunda Vistoria': ['Vistoria Corretiva']
  };

  // Opções para o tipo (dependente do subgrupo)
  Map<String, List<String>> tipoOptions = {
    'Terremoto': ['Tremor de Terra', 'Tsunami'],
    'Emanação Vulcânica': ['EV - Tipo Não Definido (COBRADE)'],
    'Movimento de Massa': [
      'Quedas, Tombamentos e Rolamentos',
      'Deslizamentos',
      'Corridas de Massa',
      'Subsidências e Colapsos'
    ],
    'Erosão': [
      'Erosão Costeira/Marinha',
      'Erosão de Margem Fluvial',
      'Erosão Continental'
    ],
    'Inudação': ['IN - Tipo Não Definido (COBRADE)'],
    'Enxurrada': ['EN - Tipo Não Definido (COBRADE)'],
    'Alagamento': ['AL - Tipo Não Definido (COBRADE)'],
    'Sistema de Grande Escala': [
      'Ciclones',
      'Frentes Frias/Zona de Convergência'
    ],
    'Tempestades': ['Tempestade Local'],
    'Temperaturas Extremas': ['Onda de Calor', 'Onda de Frio'],
    'Seca': ['Estiagem', 'Seca', 'Incêndio Florestal', 'Baixa Umidade do Ar'],
    'Epidemias': [
      'Doenças Infecciosas Virais',
      'Doenças Infecciosas Bacterianas',
      'Doenças Infecciosas Parasíticas',
      'Doenças Infecciosas Fungicas'
    ],
    'Infestação/Pragas': [
      'Infestação de Animais',
      'Infestação de Algas',
      'Outras Infestações'
    ],
    'Desastres Siderais': ['Queda de Satélite'],
    'Equipamentos Radioativos': ['Fonte Radioativa em Produção'],
    'Poluíção Radioativa': ['Outras Fontes de contaminação'],
    'Extravasamento de Produtos': ['Através de Explosão ou Incêndio'],
    'Contaminação de Água': [
      'Produto Químico em Água Potável',
      'Contaminação de Ambientes Fluviais'
    ],
    'Conflitos Bélicos': ['Contaminação por Ações Militares'],
    'Transporte de Produtos': [
      'Transporte Rodoviário',
      'Transporte Ferroviário',
      'Transporte Aéreo',
      'Transporte Dutoviário',
      'Transporte Marítimo',
      'Transporte Aquaviário'
    ],
    'Incêndios Urbanos': [
      'Incêndios em Distritos Industriais',
      'Incêndio em Aglomerações Residênciais'
    ],
    'Colapso de Edificações': ['CE - Tipo Não Definido (COBRADE)'],
    'Colapso de Barragens': ['CB - Tipo Não Definido (COBRADE)'],
    'Transporte Rodoviário': ['TR - Tipo Não Definido (COBRADE)'],
    'Transporte Ferroviário': ['TF - Tipo Não Definido (COBRADE)'],
    'Transporte Aéreo': ['TA - Tipo Não Definido (COBRADE)'],
    'Transporte Marítimo': ['TM - Tipo Não Definido (COBRADE)'],
    'Transporte Aquaviário': ['TQ - Tipo Não Definido (COBRADE)'],
    'Vistoria Solicitada': ['VS - Tipo Não Definido (COBRADE)'],
    'Vistoria Corretiva': ['VC - Tipo Não Definido (COBRADE)']
  };

  // Mapeia valores para cada opção no campo "SubTipo" (Depende do "Tipo")
  Map<String, List<String>> subTipoOptions = {
    'Tremor de Terra': ['TT - SubTipo não Definido (COBRADE)'],
    'Tsunami': ['TS - SubTipo não Definido (COBRADE)'],
    'EV - Tipo Não Definido (COBRADE)': ['EV - SubTipo não Definido (COBRADE)'],
    'Quedas, Tombamentos e Rolamentos': [
      'Blocos',
      'Lascas',
      'Matações',
      'Lajes'
    ],
    'Deslizamentos': ['Deslizamentos de Solo/Rochas'],
    'Corridas de Massa': ['Solo/Lama', 'Rocha/Detrito'],
    'Subsidências e Colapsos': ['SC - SubTipo não Definido (COBRADE)'],
    'Erosão Costeira/Marinha': ['CM - SubTipo não Definido (COBRADE)'],
    'Erosão de Margem Fluvial': ['MF - SubTipo não Definido (COBRADE)'],
    'Erosão Continental': ['Laminar', 'Ravinas', 'Boçorocas'],
    'IN - Tipo Não Definido (COBRADE)': ['IN - SubTipo não Definido (COBRADE)'],
    'EN - Tipo Não Definido (COBRADE)': ['EN - SubTipo não Definido (COBRADE)'],
    'AL - Tipo Não Definido (COBRADE)': ['AL - SubTipo não Definido (COBRADE)'],
    'Ciclones': ['Ventos Costeiros', 'Marés de Tempestades'],
    'Frentes Frias/Zona de Convergência': [
      'FF - SubTipo não Definido (COBRADE)'
    ],
    'Tempestade Local': [
      'Tornados',
      'Tempestade de Raios',
      'Granizo',
      'Chuvas Intensas',
      'Vendaval'
    ],
    'Onda de Calor': ['OC - SubTipo não Definido (COBRADE)'],
    'Onda de Frio': ['Friagem', 'Geadas'],
    'Estiagem': ['ES - SubTipo não Definido (COBRADE)'],
    'Seca': ['SE - SubTipo não Definido (COBRADE)'],
    'Incêndio Florestal': [
      'Locais de Preservação/Parques',
      'Incêndios em Áreas Protegidas'
    ],
    'Baixa Umidade do Ar': ['UA - SubTipo não Definido (COBRADE)'],
    'Doenças Infecciosas Virais': ['DV - SubTipo não Definido (COBRADE)'],
    'Doenças Infecciosas Bacterianas': ['DB - SubTipo não Definido (COBRADE)'],
    'Doenças Infecciosas Parasíticas': ['DP - SubTipo não Definido (COBRADE)'],
    'Doenças Infecciosas Fungicas': ['DF - SubTipo não Definido (COBRADE)'],
    'Infestação de Animais': ['IA - SubTipo não Definido (COBRADE)'],
    'Infestação de Algas': ['Marés Vermelhas', 'Ciáno Bactéria'],
    'Outras Infestações': ['OI - SubTipo não Definido (COBRADE)'],
    'Queda de Satélite': ['QS - SubTipo não Definido (COBRADE)'],
    'Fonte Radioativa em Produção': ['FR - SubTipo não Definido (COBRADE)'],
    'Outras Fontes de contaminação': ['OX - SubTipo não Definido (COBRADE)'],
    'Através de Explosão ou Incêndio': ['AE - SubTipo não Definido (COBRADE)'],
    'Produto Químico em Água Potável': ['PQ - SubTipo não Definido (COBRADE)'],
    'Contaminação de Ambientes Fluviais': [
      'CF - SubTipo não Definido (COBRADE)'
    ],
    'Contaminação por Ações Militares': ['AM - SubTipo não Definido (COBRADE)'],
    'Transporte Rodoviário': ['PR - SubTipo não Definido (COBRADE)'],
    'Transporte Ferroviário': ['PF - SubTipo não Definido (COBRADE)'],
    'Transporte Aéreo': ['PV - SubTipo não Definido (COBRADE)'],
    'Transporte Dutoviário': ['PD - SubTipo não Definido (COBRADE)'],
    'Transporte Marítimo': ['PM - SubTipo não Definido (COBRADE)'],
    'Transporte Aquaviário': ['PA - SubTipo não Definido (COBRADE)'],
    'Incêndios em Distritos Industriais': [
      'II - SubTipo não Definido (COBRADE)'
    ],
    'Incêndio em Aglomerações Residênciais': [
      'IR - SubTipo não Definido (COBRADE)'
    ],
    'CE - Tipo Não Definido (COBRADE)': ['CE - SubTipo não Definido (COBRADE)'],
    'CB - Tipo Não Definido (COBRADE)': ['CB - SubTipo não Definido (COBRADE)'],
    'TR - Tipo Não Definido (COBRADE)': ['TR - SubTipo não Definido (COBRADE)'],
    'TF - Tipo Não Definido (COBRADE)': ['TF - SubTipo não Definido (COBRADE)'],
    'TA - Tipo Não Definido (COBRADE)': ['TA - SubTipo não Definido (COBRADE)'],
    'TM - Tipo Não Definido (COBRADE)': ['TM - SubTipo não Definido (COBRADE)'],
    'TQ - Tipo Não Definido (COBRADE)': ['TQ - SubTipo não Definido (COBRADE)'],
    'VS - Tipo Não Definido (COBRADE)': ['VS - SubTipo não Definido (COBRADE)'],
    'VC - Tipo Não Definido (COBRADE)': ['VC - SubTipo não Definido (COBRADE)']
  };

  // Mapeia valores automáticos para cada opção no campo "Tipo"
  Map<String, Map<String, String>> valoresAutomaticosTipo = {
    'TT - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.1.1.1.0',
    },
    'TS - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.1.1.2.0',
    },
    'EV - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.1.2.0.0',
    },
    'Blocos': {
      'Cobrade': '1.1.3.1.1',
    },
    'Lascas': {
      'Cobrade': '1.1.3.1.2',
    },
    'Matações': {
      'Cobrade': '1.1.3.1.3',
    },
    'Lajes': {
      'Cobrade': '1.1.3.1.4',
    },
    'Deslizamentos de Solo/Rochas': {
      'Cobrade': '1.1.3.2.1',
    },
    'Solo/Lama': {
      'Cobrade': '1.1.3.3.1',
    },
    'Rocha/Detrito': {
      'Cobrade': '1.1.3.3.2',
    },
    'SC - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.1.3.4.0',
    },
    'CM - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.1.4.1.0',
    },
    'MF - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.1.4.2.0',
    },
    'Laminar': {
      'Cobrade': '1.1.4.3.1',
    },
    'Ravinas': {
      'Cobrade': '1.1.4.3.2',
    },
    'Boçorocas': {
      'Cobrade': '1.1.4.3.3',
    },
    'IN - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.2.1.0.0',
    },
    'EN - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.2.2.0.0',
    },
    'AL - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.2.3.0.0',
    },
    'Ventos Costeiros': {
      'Cobrade': '1.3.1.1.1',
    },
    'Marés de Tempestades': {
      'Cobrade': '1.3.1.1.2',
    },
    'FF - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.3.1.2.0',
    },
    'Tornados': {
      'Cobrade': '1.3.2.1.1',
    },
    'Tempestade de Raios': {
      'Cobrade': '1.3.2.1.2',
    },
    'Granizo': {
      'Cobrade': '1.3.2.1.3',
    },
    'Chuvas Intensas': {
      'Cobrade': '1.3.2.1.4',
    },
    'Vendaval': {
      'Cobrade': '1.3.2.1.5',
    },
    'OC - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.3.3.1.0',
    },
    'Friagem': {
      'Cobrade': '1.3.3.2.1',
    },
    'Geadas': {
      'Cobrade': '1.3.3.2.2',
    },
    'ES - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.4.1.1.0',
    },
    'SE - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.4.1.2.0',
    },
    'Locais de Preservação/Parques': {
      'Cobrade': '1.4.1.3.1',
    },
    'Incêndios em Áreas Protegidas': {
      'Cobrade': '1.4.1.3.2',
    },
    'UA - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.4.1.4.0',
    },
    'DV - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.5.1.1.0',
    },
    'DB - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.5.1.2.0',
    },
    'DP - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.5.1.3.0',
    },
    'DF - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.5.1.4.0',
    },
    'IA - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.5.2.1.0',
    },
    'Marés Vermelhas': {
      'Cobrade': '1.5.2.2.1',
    },
    'Ciáno Bactéria': {
      'Cobrade': '1.5.2.2.2',
    },
    'OI - SubTipo não Definido (COBRADE)': {
      'Cobrade': '1.5.2.3.0',
    },
    'QS - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.1.1.1.0',
    },
    'FR - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.1.2.1.0',
    },
    'OX - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.1.3.1.0',
    },
    'AE - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.1.1.0',
    },
    'PQ - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.2.1.0',
    },
    'CF - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.2.2.0',
    },
    'AM - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.3.1.0',
    },
    'PR - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.4.1.0',
    },
    'PF - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.4.2.0',
    },
    'PV - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.4.3.0',
    },
    'PD - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.4.4.0',
    },
    'PM - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.4.5.0',
    },
    'PA - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.2.4.6.0',
    },
    'II - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.3.1.1.0',
    },
    'IR - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.3.1.2.0',
    },
    'CE - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.4.1.0.0',
    },
    'CB - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.4.2.0.0',
    },
    'TR - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.5.1.0.0',
    },
    'TF - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.5.2.0.0',
    },
    'TA - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.5.3.0.0',
    },
    'TM - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.5.4.0.0',
    },
    'TQ - SubTipo não Definido (COBRADE)': {
      'Cobrade': '2.5.5.0.0',
    },
    'VS - SubTipo não Definido (COBRADE)': {
      'Cobrade': '0.0.0.0.0',
    },
    'VC - SubTipo não Definido (COBRADE)': {
      'Cobrade': '0.0.0.0.1',
    }
  };

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: BarraSuperior(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 70),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Alinhar no topo
                children: <Widget>[
                  // Campo "Classe de acontecimento"
                  DropdownButtonFormField<String>(
                    value: _selectedClasseAcontecimento,
                    items: classeOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedClasseAcontecimento = newValue!;
                        _selectedGrupo = null;
                        _selectedSubGrupo = null;
                        _selectedTipo = null;
                        _selectedSubTipo = null;
                        _selectedCobradeAutomatico = null;
                      });
                    },
                    decoration:
                        _customInputDecoration('Classe de acontecimento:'),
                  ),

                  const SizedBox(height: 30), // Espaçamento de 30 pixels

                  // Campo "Grupo" (dependente da classe de acontecimento)
                  if (_selectedClasseAcontecimento != null)
                    DropdownButtonFormField<String>(
                      value: _selectedGrupo,
                      items: grupoOptions[_selectedClasseAcontecimento!]
                              ?.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList() ??
                          [],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGrupo = newValue;
                          _selectedSubGrupo = null;
                          _selectedTipo = null;
                          _selectedSubTipo = null;
                          _selectedCobradeAutomatico = null;
                        });
                      },
                      decoration: _customInputDecoration('Grupo:'),
                    ),

                  const SizedBox(height: 30), // Espaçamento de 30 pixels

                  // Campo "Subgrupo" (dependente do grupo)
                  if (_selectedGrupo != null)
                    DropdownButtonFormField<String>(
                      value: _selectedSubGrupo,
                      items: subGrupoOptions[_selectedGrupo!]
                              ?.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList() ??
                          [],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubGrupo = newValue;
                          _selectedTipo = null;
                          _selectedSubTipo = null;
                          _selectedCobradeAutomatico = null;
                        });
                      },
                      decoration: _customInputDecoration('Subgrupo:'),
                    ),

                  const SizedBox(height: 30), // Espaçamento de 30 pixels

                  // Campo "Tipo" (dependente do subgrupo)
                  if (_selectedSubGrupo != null)
                    DropdownButtonFormField<String>(
                      value: _selectedTipo,
                      items:
                          tipoOptions[_selectedSubGrupo!]?.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList() ??
                              [],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTipo = newValue;
                          _selectedSubTipo = null;
                          _selectedCobradeAutomatico = null;
                        });

                        // Verificar se deve preencher automaticamente
                        if (_selectedTipo != null &&
                            valoresAutomaticosTipo.containsKey(_selectedTipo)) {
                          setState(() {
                            _selectedSubTipo = valoresAutomaticosTipo[
                                _selectedTipo]!['SubTipo'];
                            _selectedCobradeAutomatico = valoresAutomaticosTipo[
                                _selectedTipo]!['Cobrade'];
                          });
                        }
                      },
                      decoration: _customInputDecoration('Tipo:'),
                    ),

                  const SizedBox(height: 30), // Espaçamento de 30 pixels

                  // Campo "Subtipo" (dependente do tipo)
                  if (_selectedTipo != null)
                    DropdownButtonFormField<String>(
                      value: _selectedSubTipo,
                      items:
                          subTipoOptions[_selectedTipo!]?.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList() ??
                              [],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubTipo = newValue;

                          // Verificar se deve preencher automaticamente
                          if (_selectedSubTipo != null &&
                              valoresAutomaticosTipo
                                  .containsKey(_selectedSubTipo)) {
                            setState(() {
                              _selectedCobradeAutomatico =
                                  valoresAutomaticosTipo[_selectedSubTipo]![
                                      'Cobrade'];
                            });
                          }
                        });
                      },
                      decoration: _customInputDecoration('Subtipo:'),
                    ),

                  const SizedBox(height: 30), // Espaçamento de 30 pixels

                  // Campo "Cobrade" preenchido automaticamente
                  if (_selectedCobradeAutomatico != null)
                    TextFormField(
                      initialValue: _selectedCobradeAutomatico,
                      readOnly: true,
                      decoration: _customInputDecoration('Info Cobrade:'),
                    ),

                  const SizedBox(height: 30),

                  if (dataAtual != null) // Verifica se a data não é nula
                    TextFormField(
                      initialValue: dataAtual.toString(),
                      readOnly: true,
                      decoration: _customInputDecoration('Data e Hora:'),
                    ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Botão Salvar
                      InkWell(
                        onTap: () async {
                          var response = await _salvar();
                          
                          if (response != null) {
                            appState.atualizarTela('inicio');
                            Navigator.of(context).pushReplacementNamed('/tela-inicio');
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 28.61,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF30BD4F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Center(
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
                        ),
                      ),

                      const SizedBox(width: 10), // Adiciona um espaçamento entre os botões

                      // Botão Cancelar
                      InkWell(
                        onTap: () {
                          // Navega de volta para a tela Home
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Home(title: ''),
                            ),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 28.61,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFEC6F64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Center(
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}

class _selecteddataAtual {}