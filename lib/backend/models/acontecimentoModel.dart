class AcontecimentoModel {
  final String? id;
  final String classe;
  final String grupo;
  final String subgrupo;
  final String tipo;
  final String subtipo;
  final String? infoCobrade;
  final DateTime dataHora;
  final String? numeroProtocolo;
  final String cidadaoResponsavel;
  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  bool? pendente;

  AcontecimentoModel({
    this.id,
    required this.classe,
    required this.grupo,
    required this.subgrupo,
    required this.tipo,
    required this.subtipo,
    this.infoCobrade,
    required this.dataHora,
    this.numeroProtocolo,
    required this.cidadaoResponsavel,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
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
      dataHora: DateTime.parse(json['dataHora']),
      numeroProtocolo: json['numeroProtocolo'],
      cidadaoResponsavel: json['cidadaoResponsavel'],
      cep: json['cep'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      pendente: json['pendente'] as bool?,
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
        'dataHora': dataHora.toIso8601String(),
        'numeroProtocolo': numeroProtocolo,
        'cidadaoResponsavel': cidadaoResponsavel,
        'cep': cep,
        'rua': rua,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
        'pendente': pendente,
      };
}