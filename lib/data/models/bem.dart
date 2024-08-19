class Bem {
  final String descricao;
  final int id;
  final String? patrimonio;
  final bool semEtiqueta;
  final String? numeroSerie;
  final String estadoBem;
  final bool bemParticular;
  final bool indicaDesfazimento;
  final String? observacoes;
  final String localidadeId;
  final String campusId;
  final String imagem;
  final String nomeUsuario;
  final String uidUsuario;
  final DateTime dataCadastro;
  final bool aCorrigir;
  Bem(
      {required this.id,
      required this.descricao,
      required this.patrimonio,
      required this.bemParticular,
      required this.estadoBem,
      required this.indicaDesfazimento,
      required this.numeroSerie,
      required this.observacoes,
      required this.semEtiqueta,
      required this.imagem,
      required this.campusId,
      required this.localidadeId,
      required this.nomeUsuario,
      required this.uidUsuario,
      required this.dataCadastro,
      required this.aCorrigir});

  String get titulo {
    if (patrimonio != null && patrimonio!.isNotEmpty) {
      return '$descricao - $patrimonio';
    } else {
      return descricao;
    }
  }

  String get dataCadastroFormatada {
    return '${dataCadastro.day}/${dataCadastro.month}/${dataCadastro.year} - ${dataCadastro.hour}:${dataCadastro.minute}';
  }

  factory Bem.fromMap(Map<String, dynamic> data) {
    return Bem(
        id: data['id'],
        descricao: data['descricao'],
        patrimonio: data['patrimonio'],
        bemParticular: data['bemParticular'] ?? false, //Testes
        estadoBem: data['estadoBem'] ?? 'uso',
        indicaDesfazimento: data['indicaDesfazimento'] ?? false, //Testes
        numeroSerie: data['numeroSerie'],
        observacoes: data['observacoes'],
        semEtiqueta: data['semEtiqueta'] ?? false, //testes,
        imagem: data['imagem'],
        campusId: data['campusId'],
        localidadeId: data['localidadeId'],
        dataCadastro: data['timestamp'] != null
            ? data['timestamp'].toDate()
            : DateTime.now(), //Colocado para testes
        nomeUsuario: data['nomeUsuario'] ?? "Usuario teste",
        uidUsuario: data['uidUsuario'] ?? 'uidteste',
        aCorrigir: data['aCorrigir'] ?? false);
  }

  @override
  String toString() {
    return 'Bem: $descricao - Patrimônio: $patrimonio';
  }
}
