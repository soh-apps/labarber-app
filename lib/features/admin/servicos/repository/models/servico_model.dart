class ServicoModel {
  final String? idServico;
  final String nome;
  final String urlImagem;
  final String? descricao;
  final String tempoServico;
  final double valor;
  final double comissao;

  final int? barberUnitId;
  final int porcentagemComissao;

  ServicoModel({
    required this.nome,
    required this.valor,
    required this.comissao,
    required this.tempoServico,
    required this.porcentagemComissao,
    this.descricao,
    this.idServico,
    this.urlImagem = '',
    this.barberUnitId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': idServico,
      'name': nome,
      'urlImage': urlImagem,
      'value': valor,
      'valueComission': comissao,
      'description': descricao,
      'timeToComplete': tempoServico,
      'barberUnitId': barberUnitId,
      'porcentagemComissao': porcentagemComissao,
    };
  }

  factory ServicoModel.fromMap(Map<String, dynamic> map) {
    return ServicoModel(
      idServico: map['id'] as String,
      nome: map['name'] as String,
      urlImagem: map['urlImage'] != null ? map['urlImage'] as String : '',
      tempoServico: map['timeToComplete'] != null ? map['timeToComplete'] as String : '',
      valor: (map['value'] as num).toDouble(),
      comissao: (map['valueComission'] as num).toDouble(),
      descricao: map['description'] != null ? (map['descricao'] as num).toString() : null,
      barberUnitId: map['barberUnitId'] != null ? (map['barberUnitId'] as num).toInt() : null,
      porcentagemComissao: map['barberUnitId'] != null ? (map['barberUnitId'] as num).toInt() : 0,
    );
  }

  static List<ServicoModel> fromList(List<dynamic> list) {
    return list.map((item) => ServicoModel.fromMap(item)).toList();
  }
}
