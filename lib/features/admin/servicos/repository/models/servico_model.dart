class ServicoModel {
  final String? idServico;
  final String nome;
  final String? urlImagem;
  final double valor;
  final double comissao;
  final String? descricao;
  final int? unitId;

  ServicoModel({
    required this.nome,
    required this.valor,
    required this.comissao,
    this.descricao,
    this.idServico,
    this.urlImagem,
    this.unitId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServico': idServico,
      'nome': nome,
      'urlImagem': urlImagem,
      'valor': valor,
      'comissao': comissao,
      'descricao': descricao,
      'unitId': unitId,
    };
  }

  factory ServicoModel.fromMap(Map<String, dynamic> map) {
    return ServicoModel(
      idServico: map['idServico'] as String,
      nome: map['nome'] as String,
      urlImagem: map['urlImagem'] != null ? map['urlImagem'] as String : null,
      valor: (map['valor'] as num).toDouble(),
      comissao: (map['comissao'] as num).toDouble(),
      descricao: map['descricao'] != null ? (map['descricao'] as num).toString() : null,
      unitId: map['unitId'] != null ? (map['unitId'] as num).toInt() : null,
    );
  }

  static List<ServicoModel> fromList(List<dynamic> list) {
    return list.map((item) => ServicoModel.fromMap(item)).toList();
  }
}
