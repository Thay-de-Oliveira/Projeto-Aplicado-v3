class UserModel {
  final String? id;
  final String username;
  final String email;
  final String? password;
  final String cpf;
  final String telefone;
  final String cargo;
  final String cidadeDeAtuacao;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    this.password,
    required this.cpf,
    required this.telefone,
    required this.cargo,
    required this.cidadeDeAtuacao,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      cargo: json['cargo'],
      cidadeDeAtuacao: json['cidadeDeAtuacao'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'cpf': cpf,
        'telefone': telefone,
        'cargo': cargo,
        'cidadeDeAtuacao': cidadeDeAtuacao,
      };
}