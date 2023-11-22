class AcontecimentoModel {
  final String? id;
  final String classe;
  final String grupo;
  final String subgrupo;
  final String tipo;
  final String subtipo;
  final String infoCobrade;
  final DateTime dataHora;
  final String numeroProtocolo;

  AcontecimentoModel({
    this.id,
    required this.classe,
    required this.grupo,
    required this.subgrupo,
    required this.tipo,
    required this.subtipo,
    required this.infoCobrade,
    required this.dataHora,
    required this.numeroProtocolo,
  });

  factory AcontecimentoModel.fromJson(Map<String, dynamic> json) {
    return AcontecimentoModel(
      id: json['id'],
      classe: json['classe'],
      grupo: json['grupo'],
      subgrupo: json['subgrupo'],
      tipo: json['tipo'],
      subtipo: json['subtipo'],
      infoCobrade: json['infoCobrade'],
      dataHora: DateTime.parse(json['dataHora']),
      numeroProtocolo: json['numeroProtocolo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'classe': classe,
        'grupo': grupo,
        'subgrupo': subgrupo,
        'tipo': tipo,
        'subtipo': subtipo,
        'infoCobrade': infoCobrade,
        'dataHora': dataHora.toIso8601String(),
        'numeroProtocolo': numeroProtocolo,
      };
}
