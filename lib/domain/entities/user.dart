class UserData {
  final String id;
  final String email;
  final String name;
  final String siape;
  final String cpf;

  UserData(
      {required this.id,
      required this.email,
      required this.name,
      required this.siape,
      required this.cpf});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      siape: json['siape'],
      cpf: json['cpf'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'siape': siape,
      'cpf': cpf,
    };
  }
}
