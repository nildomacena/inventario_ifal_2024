class Localidade {
  final int localidadeId;
  final int inventarioId;
  final String nome;
  final String ano;
  final String? relatorio;
  final int? numeroBens;
  final String status;

  Localidade({
    required this.localidadeId,
    required this.nome,
    required this.ano,
    required this.relatorio,
    required this.inventarioId,
    required this.status,
    this.numeroBens,
  });

  String get statusFormatado {
    switch (status) {
      case 'nao_iniciada':
        return 'Não iniciada';
      case 'finalizada':
        return 'Finalizada';
      case 'em_andamento':
        return 'Em andamento';
      default:
        return 'Não informado';
    }
  }

  factory Localidade.fromJson(Map<String, dynamic> json) {
    return Localidade(
      localidadeId: json['localidade_id'],
      inventarioId: json['inventario_localidade_id'],
      nome: json['localidade_nome'],
      ano: json['ano_inventario'],
      relatorio: json['relatorio'],
      status: json['status_inventario'],
      numeroBens: json['numero_bens'],
    );
  }
}
