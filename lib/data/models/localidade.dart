class Localidade {
  final String nome;

  Localidade({required this.nome});

  factory Localidade.fromJson(Map<String, dynamic> json) {
    return Localidade(
      nome: json['nome'],
    );
  }
}
