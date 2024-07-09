class ViaCEPModel {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String ibge;
  String gia;
  String ddd;
  String siafi;

  ViaCEPModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  // Factory constructor to create a new instance from a JSON object
  factory ViaCEPModel.fromJson(Map<String, dynamic> json) {
    return ViaCEPModel(
      cep: json['cep'] ?? "",
      logradouro: json['logradouro'] ?? "",
      complemento: json['complemento'] ?? "",
      bairro: json['bairro'] ?? "",
      localidade: json['localidade'] ?? "",
      uf: json['uf'] ?? "",
      ibge: json['ibge'] ?? "",
      gia: json['gia'] ?? "",
      ddd: json['ddd'] ?? "",
      siafi: json['siafi'] ?? "",
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
    };
  }
}
