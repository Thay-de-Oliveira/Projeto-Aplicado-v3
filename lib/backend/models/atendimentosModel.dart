class AtendimentosModel {
  final String? id;
  final String n_protocolo;
  final String tipoAtendimento;
  final String canalAtendimento;
  final String nomeResponsavel;
  final String vistoriaRealizada;
  final String tipoVistoria;
  final String dataSolicitacao;
  final String dataVistoria;
  final Boolean entregueItensAjuda;

  AtendimentosModel({
    this.id,
    required this.n_protocolo,
    required this.tipoAtendimento,
    required this.canalAtendimento,
    required this.nomeResponsavel,
    required this.vistoriaRealizada,
    required this.tipoVistoria,
    required this.dataSolicitacao,
    required this.dataVistoria,
    required this.entregueItensAjuda,
  });

  factory AtendimentosModel.fromJson(Map<String, dynamic> json) {
    return AtendimentosModel(
      id: json['id'],
      n_protocolo: json['n_protocolo'],
      tipoAtendimento: json['TipoAtendimento'],
      canalAtendimento: json['CanalAtendimento'],
      nomeResponsavel: json['NomeResponsavel'],
      vistoriaRealizada: json['VistoriaRealizada'],
      tipoVistoria: json['TipoVistoria'],
      dataSolicitacao: json['dataSolicitacao'],
      dataVistoria: json['dataVistoria'],
      entregueItensAjuda: json['entregueItensAjuda'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'n_protocolo': n_protocolo,
        'TipoAtendimento': tipoAtendimento,
        'CanalAtendimento': canalAtendimento,
        'tipo': tipo,
        'vistoriaRealizada': vistoriaRealizada,
        'TipoVistoria': tipoVistoria,
        'dataSolicitacao': dataSolicitacao,
        'dataVistoria': dataVistoria,
        'entregueItensAjuda': entregueItensAjuda,
      };
}
