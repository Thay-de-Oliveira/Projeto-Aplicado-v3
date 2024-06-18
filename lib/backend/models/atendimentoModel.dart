class AtendimentosModel {
  final String? id;
  final String nProtocolo;
  final String tipoAtendimento;
  final String canalAtendimento;
  final String cidadaoResponsavel;
  final bool vistoriaRealizada;
  final String? tipoVistoria;
  final String dataSolicitacao;
  final String dataVistoria;
  final bool entregueItensAjuda;
  final List<String> materiaisEntregues;
  final String? observacoes;
  final String? pdfUrl;
  final String atendenteResponsavel;
  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  bool pendente;
  final List<String>? imagesUrls;

  AtendimentosModel({
    this.id,
    required this.nProtocolo,
    required this.tipoAtendimento,
    required this.canalAtendimento,
    required this.cidadaoResponsavel,
    required this.vistoriaRealizada,
    this.tipoVistoria,
    required this.dataSolicitacao,
    required this.dataVistoria,
    required this.entregueItensAjuda,
    required this.materiaisEntregues,
    this.observacoes,
    this.pdfUrl,
    required this.atendenteResponsavel,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.pendente,
    this.imagesUrls,
  });

  factory AtendimentosModel.fromJson(Map<String, dynamic> json) {
    return AtendimentosModel(
      id: json['_id'],
      nProtocolo: json['nProtocolo'],
      tipoAtendimento: json['tipoAtendimento'],
      canalAtendimento: json['canalAtendimento'],
      cidadaoResponsavel: json['cidadaoResponsavel'],
      vistoriaRealizada: json['vistoriaRealizada'],
      tipoVistoria: json['tipoVistoria'],
      dataSolicitacao: json['dataSolicitacao'],
      dataVistoria: json['dataVistoria'],
      entregueItensAjuda: json['entregueItensAjuda'],
      materiaisEntregues: List<String>.from(json['materiaisEntregues']),
      observacoes: json['observacoes'],
      pdfUrl: json['pdfUrl'],
      atendenteResponsavel: json['atendenteResponsavel'],
      cep: json['cep'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      pendente: json['pendente'],
      imagesUrls: json['imagesUrls'] != null ? List<String>.from(json['imagesUrls']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'nProtocolo': nProtocolo,
        'tipoAtendimento': tipoAtendimento,
        'canalAtendimento': canalAtendimento,
        'cidadaoResponsavel': cidadaoResponsavel,
        'vistoriaRealizada': vistoriaRealizada,
        'tipoVistoria': tipoVistoria,
        'dataSolicitacao': dataSolicitacao,
        'dataVistoria': dataVistoria,
        'entregueItensAjuda': entregueItensAjuda,
        'materiaisEntregues': materiaisEntregues,
        'observacoes': observacoes,
        'pdfUrl': pdfUrl,
        'atendenteResponsavel': atendenteResponsavel,
        'cep': cep,
        'rua': rua,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
        'pendente': pendente,
        'imagesUrls': imagesUrls,
      };
}