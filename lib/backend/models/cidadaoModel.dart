class CidadaoModel {
  final String? id;
  final String name;
  final String cpf;
  final String rg;
  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  final int numeroCasa;
  final int numPessoasNaCasa;
  final String telefone;

  CidadaoModel({
    this.id,
    required this.name,
    required this.cpf,
    required this.rg,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.numeroCasa,
    required this.numPessoasNaCasa,
    required this.telefone,
  });

  factory CidadaoModel.fromJson(Map<String, dynamic> json) {
    return CidadaoModel(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      rg: json['rg'],
      cep: json['cep'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      numeroCasa: json['numeroCasa'],
      numPessoasNaCasa: json['numPessoasNaCasa'],
      telefone: json['telefone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'cpf': cpf,
    'rg': rg,
    'cep': cep,
    'rua': rua,
    'bairro': bairro,
    'cidade': cidade,
    'estado': estado,
    'numeroCasa': numeroCasa,
    'numPessoasNaCasa': numPessoasNaCasa,
    'telefone': telefone,
  };
}
