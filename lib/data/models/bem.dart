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
  final int localidadeId;
  final String? campusId;
  final String imagem;
  final String nomeUsuario;
  final int idUsuario;
  final DateTime dataCadastro;
  final bool aCorrigir;
  final String anoInventario;

  Bem({
    required this.id,
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
    required this.idUsuario,
    required this.dataCadastro,
    required this.aCorrigir,
    required this.anoInventario,
  });

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
      bemParticular: data['bem_particular'] ?? false, //Testes
      estadoBem: data['estado_bem'] ?? 'uso',
      indicaDesfazimento: data['indica_desfaziamento'] ?? false, //Testes
      numeroSerie: data['numero_serie'],
      observacoes: data['observacoes'],
      semEtiqueta: data['sem_etiqueta'] ?? false, //testes,
      imagem: data['imagem'],
      campusId: data['campusId'],
      localidadeId: data['localidade_id'],
      dataCadastro: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : DateTime.now(), //Colocado para testes
      nomeUsuario: data['usuario_id']?.toString() ?? "Usuario teste",
      idUsuario: data['usuario_id'] ?? 'uidteste',
      aCorrigir: data['aCorrigir'] ?? false,
      anoInventario: data['ano_inventario'],
    );
  }

  @override
  String toString() {
    return 'Bem: $descricao - Patrimônio: $patrimonio';
  }
}
