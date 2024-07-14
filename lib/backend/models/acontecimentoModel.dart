class AcontecimentoModel {
  final String? id;
  final String classe;
  final String grupo;
  final String subgrupo;
  final String tipo;
  final String subtipo;
  final String infoCobrade;
  final String dataHora;
  final String? numeroProtocolo;
  final String canalAtendimento;
  final String nomeCidadaoResponsavel;
  final String cpfCidadaoResponsavel;
  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  final int? numeroCasa;
  bool? pendente;

  AcontecimentoModel({
    this.id,
    required this.classe,
    required this.grupo,
    required this.subgrupo,
    required this.tipo,
    required this.subtipo,
    required this.infoCobrade,
    required this.dataHora,
    this.numeroProtocolo,
    required this.canalAtendimento,
    required this.nomeCidadaoResponsavel,
    required this.cpfCidadaoResponsavel,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.numeroCasa,
    this.pendente,
  });

  factory AcontecimentoModel.fromJson(Map<String, dynamic> json) {
    return AcontecimentoModel(
      id: json['_id'],
      classe: json['classe'],
      grupo: json['grupo'],
      subgrupo: json['subgrupo'],
      tipo: json['tipo'],
      subtipo: json['subtipo'],
      infoCobrade: json['infoCobrade'],
      dataHora: json['dataHora'],
      numeroProtocolo: json['numeroProtocolo'],
      canalAtendimento: json['canalAtendimento'],
      nomeCidadaoResponsavel: json['nomeCidadaoResponsavel'],
      cpfCidadaoResponsavel: json['cpfCidadaoResponsavel'],
      cep: json['cep'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      numeroCasa: json['numeroCasa'],
      pendente: json['pendente'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'classe': classe,
    'grupo': grupo,
    'subgrupo': subgrupo,
    'tipo': tipo,
    'subtipo': subtipo,
    'infoCobrade': infoCobrade,
    'dataHora': dataHora,
    'numeroProtocolo': numeroProtocolo,
    'canalAtendimento': canalAtendimento,
    'nomeCidadaoResponsavel': nomeCidadaoResponsavel,
    'cpfCidadaoResponsavel': cpfCidadaoResponsavel,
    'cep': cep,
    'rua': rua,
    'bairro': bairro,
    'cidade': cidade,
    'estado': estado,
    'numeroCasa': numeroCasa,
    'pendente': pendente,
  };
}