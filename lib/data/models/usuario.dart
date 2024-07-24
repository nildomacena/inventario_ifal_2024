//classe usuario possui os atributos id, nome, cpf e siape

class Usuario {
  final int id;
  final String uid;
  final String nome;
  final String cpf;
  final String siape;
  final String email;

  Usuario({
    required this.id,
    required this.uid,
    required this.nome,
    required this.cpf,
    required this.siape,
    required this.email,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      uid: json['uid'],
      nome: json['nome'],
      cpf: json['cpf'],
      siape: json['siape'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'nome': nome,
      'cpf': cpf,
      'siape': siape,
      'email': email,
    };
  }
}
