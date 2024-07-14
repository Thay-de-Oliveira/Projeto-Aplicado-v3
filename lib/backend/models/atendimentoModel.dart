class AtendimentosModel {
  final String? id;
  final String nProtocolo;
  final String tipoAtendimento;
  final String nomeCidadaoResponsavel;
  final String cpfCidadaoResponsavel;
  final bool vistoriaRealizada;
  final String? tipoVistoria;
  final String dataSolicitacao;
  final String dataAtendimento;
  final String? dataVistoria;
  final bool entregueItensAjuda;
  final List<String> materiaisEntregues;
  final String? observacoes;
  final String? pdfUrl;
  final String? pdfReciboUrl;
  final String atendenteResponsavel;
  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  final int? numeroCasa;
  bool pendente;
  final List<String>? imagesUrls;

  AtendimentosModel({
    this.id,
    required this.nProtocolo,
    required this.tipoAtendimento,
    required this.nomeCidadaoResponsavel,
    required this.cpfCidadaoResponsavel,
    required this.vistoriaRealizada,
    this.tipoVistoria,
    required this.dataSolicitacao,
    required this.dataAtendimento,
    this.dataVistoria,
    required this.entregueItensAjuda,
    required this.materiaisEntregues,
    this.observacoes,
    this.pdfUrl,
    this.pdfReciboUrl,
    required this.atendenteResponsavel,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.numeroCasa,
    required this.pendente,
    this.imagesUrls,
  });

  factory AtendimentosModel.fromJson(Map<String, dynamic> json) {
    return AtendimentosModel(
      id: json['_id'],
      nProtocolo: json['nProtocolo'],
      tipoAtendimento: json['tipoAtendimento'],
      nomeCidadaoResponsavel: json['nomeCidadaoResponsavel'],
      cpfCidadaoResponsavel: json['cpfCidadaoResponsavel'],
      vistoriaRealizada: json['vistoriaRealizada'],
      tipoVistoria: json['tipoVistoria'],
      dataSolicitacao: json['dataSolicitacao'],
      dataAtendimento: json['dataAtendimento'],
      dataVistoria: json['dataVistoria'],
      entregueItensAjuda: json['entregueItensAjuda'],
      materiaisEntregues: List<String>.from(json['materiaisEntregues']),
      observacoes: json['observacoes'],
      pdfUrl: json['pdfUrl'],
      pdfReciboUrl: json['pdfReciboUrl'],
      atendenteResponsavel: json['atendenteResponsavel'],
      cep: json['cep'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      numeroCasa: json['numeroCasa'],
      pendente: json['pendente'],
      imagesUrls: json['imagesUrls'] != null ? List<String>.from(json['imagesUrls']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'nProtocolo': nProtocolo,
        'tipoAtendimento': tipoAtendimento,
        'nomeCidadaoResponsavel': nomeCidadaoResponsavel,
        'cpfCidadaoResponsavel': cpfCidadaoResponsavel,
        'vistoriaRealizada': vistoriaRealizada,
        'tipoVistoria': tipoVistoria,
        'dataSolicitacao': dataSolicitacao,
        'dataAtendimento': dataAtendimento,
        'dataVistoria': dataVistoria,
        'entregueItensAjuda': entregueItensAjuda,
        'materiaisEntregues': materiaisEntregues,
        'observacoes': observacoes,
        'pdfUrl': pdfUrl,
        'pdfReciboUrl': pdfReciboUrl,
        'atendenteResponsavel': atendenteResponsavel,
        'cep': cep,
        'rua': rua,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
        'numeroCasa': numeroCasa,
        'pendente': pendente,
        'imagesUrls': imagesUrls,
      };
}