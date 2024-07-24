class Unidade {
  int id;
  String nome;
  String sigla;
  String? cnes;
  bool bolPermiteRegulacao;
  bool bolPermiteSolicitarRegulacao;
  bool bolMostraLogin;
  List<Procedimento> procedimentosPermitidos;
  List<TipoLeito> tipoLeitoRegPermitidos;
  bool bolGesthosp;

  Unidade({
    required this.id,
    required this.nome,
    required this.sigla,
    required this.cnes,
    required this.bolPermiteRegulacao,
    required this.bolPermiteSolicitarRegulacao,
    required this.bolMostraLogin,
    required this.procedimentosPermitidos,
    required this.tipoLeitoRegPermitidos,
    required this.bolGesthosp,
  });

  factory Unidade.fromJson(Map<String, dynamic> json) {
    return Unidade(
      id: json['id'],
      nome: json['nome'],
      sigla: json['sigla'],
      cnes: json['cnes'],
      bolPermiteRegulacao: json['bolPermiteRegulacao'],
      bolPermiteSolicitarRegulacao: json['bolPermiteSolicitarRegulacao'],
      bolMostraLogin: json['bolMostraLogin'] ?? false,
      procedimentosPermitidos: List<Procedimento>.from(json['procedimentosPermitidos'].map((x) => Procedimento.fromJson(x))),
      tipoLeitoRegPermitidos: List<TipoLeito>.from(json['tipoLeitoRegPermitidos'].map((x) => TipoLeito.fromJson(x))),
      bolGesthosp: json['bolGesthosp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
      'cnes': cnes,
      'bolPermiteRegulacao': bolPermiteRegulacao,
      'bolPermiteSolicitarRegulacao': bolPermiteSolicitarRegulacao,
      'bolMostraLogin': bolMostraLogin,
      'procedimentosPermitidos': List<dynamic>.from(procedimentosPermitidos.map((x) => x.toJson())),
      'tipoLeitoRegPermitidos': List<dynamic>.from(tipoLeitoRegPermitidos.map((x) => x.toJson())),
      'bolGesthosp': bolGesthosp,
    };
  }
}

class Procedimento {
  int id;
  GrupoProcedimento grupoProcedimento;
  String nome;
  String descricao;
  ProcedimentoSigtap procedimentoSigtap;
  bool geraApac;

  Procedimento({
    required this.id,
    required this.grupoProcedimento,
    required this.nome,
    required this.descricao,
    required this.procedimentoSigtap,
    required this.geraApac,
  });

  factory Procedimento.fromJson(Map<String, dynamic> json) {
    return Procedimento(
      id: json['id'],
      grupoProcedimento: GrupoProcedimento.fromJson(json['grupoProcedimento']),
      nome: json['nome'],
      descricao: json['descricao'],
      procedimentoSigtap: ProcedimentoSigtap.fromJson(json['procedimentoSigtap']),
      geraApac: json['geraApac'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grupoProcedimento': grupoProcedimento.toJson(),
      'nome': nome,
      'descricao': descricao,
      'procedimentoSigtap': procedimentoSigtap.toJson(),
      'geraApac': geraApac,
    };
  }
}

class GrupoProcedimento {
  int id;
  String nome;
  bool geraSolicitacaoExame;

  GrupoProcedimento({
    required this.id,
    required this.nome,
    required this.geraSolicitacaoExame,
  });

  factory GrupoProcedimento.fromJson(Map<String, dynamic> json) {
    return GrupoProcedimento(
      id: json['id'],
      nome: json['nome'],
      geraSolicitacaoExame: json['geraSolicitacaoExame'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'geraSolicitacaoExame': geraSolicitacaoExame,
    };
  }
}

class ProcedimentoSigtap {
  int id;
  String codigo;
  String descricao;
  int qtdDias;

  ProcedimentoSigtap({
    required this.id,
    required this.codigo,
    required this.descricao,
    required this.qtdDias,
  });

  factory ProcedimentoSigtap.fromJson(Map<String, dynamic> json) {
    return ProcedimentoSigtap(
      id: json['id'],
      codigo: json['codigo'],
      descricao: json['descricao'],
      qtdDias: json['qtdDias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'descricao': descricao,
      'qtdDias': qtdDias,
    };
  }
}

class TipoLeito {
  int id;
  String descricao;

  TipoLeito({
    required this.id,
    required this.descricao,
  });

  factory TipoLeito.fromJson(Map<String, dynamic> json) {
    return TipoLeito(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }
}
