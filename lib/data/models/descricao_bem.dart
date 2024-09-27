class DescricaoBem {
  int numTombamento;
  String denominacao;
  String especificacao;

  DescricaoBem({
    required this.numTombamento,
    required this.denominacao,
    required this.especificacao,
  });

  factory DescricaoBem.fromJson(Map<String, dynamic> json) {
    return DescricaoBem(
      numTombamento: json['num_tombamento'],
      denominacao: json['denominacao'],
      especificacao: json['especificacao'],
    );
  }

  @override
  String toString() {
    return 'DescricaoBem{numTombamento: $numTombamento, denominacao: $denominacao, especificacao: $especificacao}';
  }
}
