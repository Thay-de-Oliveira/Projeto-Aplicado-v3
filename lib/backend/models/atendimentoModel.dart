class AtendimentosModel {
  final String? id;
  final String n_protocolo;
  final String tipoAtendimento;
  final String canalAtendimento;
  final String nomeResponsavel;
  final bool vistoriaRealizada;
  final String? tipoVistoria;
  final String dataSolicitacao;
  final String dataVistoria;
  final bool entregueItensAjuda;
  final List<String> materiaisEntregues;
  final String? observacoes;
  final String? pdfUrl;
  bool pendente;
  final List<String>? imagesUrls;

  AtendimentosModel({
    this.id,
    required this.n_protocolo,
    required this.tipoAtendimento,
    required this.canalAtendimento,
    required this.nomeResponsavel,
    required this.vistoriaRealizada,
    this.tipoVistoria,
    required this.dataSolicitacao,
    required this.dataVistoria,
    required this.entregueItensAjuda,
    required this.materiaisEntregues,
    this.observacoes,
    this.pdfUrl,
    required this.pendente,
    this.imagesUrls,
  });

  factory AtendimentosModel.fromJson(Map<String, dynamic> json) {
    return AtendimentosModel(
      id: json['_id'],
      n_protocolo: json['n_protocolo'],
      tipoAtendimento: json['TipoAtendimento'],
      canalAtendimento: json['CanalAtendimento'],
      nomeResponsavel: json['NomeResponsavel'],
      vistoriaRealizada: json['VistoriaRealizada'],
      tipoVistoria: json['TipoVistoria'],
      dataSolicitacao: json['DataSolicitacao'],
      dataVistoria: json['DataVistoria'],
      entregueItensAjuda: json['EntregueItensAjuda'],
      materiaisEntregues: List<String>.from(json['MateriaisEntregues']),
      observacoes: json['Observacoes'],
      pdfUrl: json['pdfUrl'],
      pendente: json['pendente'],
      imagesUrls: List<String>.from(json['imagesUrls']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'n_protocolo': n_protocolo,
    'TipoAtendimento': tipoAtendimento,
    'CanalAtendimento': canalAtendimento,
    'NomeResponsavel': nomeResponsavel,
    'VistoriaRealizada': vistoriaRealizada,
    'TipoVistoria': tipoVistoria,
    'DataSolicitacao': dataSolicitacao,
    'DataVistoria': dataVistoria,
    'EntregueItensAjuda': entregueItensAjuda,
    'MateriaisEntregues': materiaisEntregues,
    'Observacoes': observacoes,
    'pdfUrl': pdfUrl,
    'pendente': pendente,
    'imagesUrls': imagesUrls,
  };
}