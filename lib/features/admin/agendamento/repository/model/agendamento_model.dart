import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_barber/core/utils/enums/agendamento_status_enum.dart';

class AgendamentoModel {
  int idAgendamento;
  int idBarbeiro;
  int? idCliente;
  String nomeCliente;
  String nomeBarbeiro;
  String telefoneCliente;
  String telefoneBarbeiro;
  List<dynamic> servicos;
  DateTime data;
  double valorTotal;
  double valorTotalComissao;
  double restoDaComissao;
  String horario;
  AgendamentoStatus status;
  double desconto;
  String comentario;
  String? formaDePagamento;
  final String unidade;
  AgendamentoModel({
    required this.idAgendamento,
    required this.idBarbeiro,
    required this.idCliente,
    required this.nomeCliente,
    required this.nomeBarbeiro,
    required this.telefoneCliente,
    required this.telefoneBarbeiro,
    required this.servicos,
    required this.data,
    required this.valorTotal,
    required this.valorTotalComissao,
    required this.restoDaComissao,
    required this.horario,
    required this.status,
    required this.desconto,
    required this.comentario,
    this.formaDePagamento,
    required this.unidade,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idAgendamento': idAgendamento,
      'idBarbeiro': idBarbeiro,
      'idCliente': idCliente,
      'nomeCliente': nomeCliente,
      'nomeBarbeiro': nomeBarbeiro,
      'telefoneCliente': telefoneCliente,
      'telefoneBarbeiro': telefoneBarbeiro,
      'servicos': servicos,
      'data': data,
      'valorTotal': valorTotal,
      'valorTotalComissao': valorTotalComissao,
      'restoDaComissao': restoDaComissao,
      'horario': horario,
      'status': AgendamentoStatusHelper.getStatusCode(status),
      'desconto': desconto,
      'comentario': comentario,
      'unidade': unidade,
      'formaDePagamento': formaDePagamento,
    };
  }

  factory AgendamentoModel.fromMap(Map<String, dynamic> map) {
    // Convertendo os elementos da lista 'servicos' para String
    List<dynamic> servicosList = map['servicos'] as List<dynamic>;
    List<String> servicosFormatados = servicosList.map((servico) => servico.toString()).toList();

    return AgendamentoModel(
      idAgendamento: map['idAgendamento'] as int,
      idBarbeiro: map['idBarbeiro'] as int,
      idCliente: map['idCliente'],
      nomeCliente: map['nomeCliente'] as String,
      nomeBarbeiro: map['nomeBarbeiro'] as String,
      telefoneCliente: map['telefoneCliente'] as String,
      telefoneBarbeiro: map['telefoneBarbeiro'] as String,
      data: (map['data'] as Timestamp).toDate(),
      valorTotal: (map['valorTotal'] as num).toDouble(),
      valorTotalComissao: (map['valorTotalComissao'] as num).toDouble(),
      restoDaComissao: (map['restoDaComissao'] as num).toDouble(),
      horario: map['horario'] as String,
      status: AgendamentoStatusHelper.getStatus(map['status']),
      desconto: (map['desconto'] as num).toDouble(),
      comentario: map['comentario'] as String,
      unidade: map['unidade'] as String,
      formaDePagamento: map['formaDePagamento'] != null ? map['formaDePagamento'] as String : null,
      servicos: servicosFormatados,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgendamentoModel.fromJson(String source) =>
      AgendamentoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
