class AtendimentosModel {
  final String? id;
  final String n_protocolo;
  final String tipoAtendimento;
  final String canalAtendimento;
  final String nomeResponsavel;
  final bool vistoriaRealizada; // Corrigido para bool
  final String tipoVistoria;
  final String dataSolicitacao;
  final String dataVistoria;
  final bool entregueItensAjuda;
  bool pendente;

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
    required this.pendente,
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
      dataSolicitacao: json['DataSolicitacao'], // Corrigido para 'DataSolicitacao'
      dataVistoria: json['DataVistoria'], // Corrigido para 'DataVistoria'
      entregueItensAjuda: json['EntregueItensAjuda'],
      pendente: json['pendente'],
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
        'pendente': pendente,
      };
}
