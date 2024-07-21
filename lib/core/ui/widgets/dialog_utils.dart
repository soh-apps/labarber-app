import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/di/di.dart';
import 'package:la_barber/core/ui/forma_pagamento_dropdown.dart';
import 'package:la_barber/core/ui/widgets/barbershop_loader.dart';
import 'package:la_barber/features/admin/agendamento/presentation/cubits/agendamento_cubit.dart';

void showLoadingDialog(BuildContext context, {String message = "Loading"}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const BarbershopLoader();
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

void showCancelarDialog(BuildContext context) {
  TextEditingController observacaoController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancelar Agendamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tem certeza que deseja cancelar o agendamento?'),
            TextFormField(
              controller: observacaoController,
              decoration: const InputDecoration(labelText: 'Observação'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Cancelar o agendamento com a observação
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}

void showFinalizarDialog({required BuildContext context, required int idAgendamento}) {
  String? formaPagamentoValue;
  bool? isFormaPagamentoValid;
  TextEditingController observacaoController = TextEditingController();
  final AgendamentoCubit agendamentoCubit = getIt();
  agendamentoCubit.resetStatus();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<AgendamentoCubit, AgendamentoState>(
        bloc: agendamentoCubit,
        builder: (context, state) {
          if (state is AgendamentoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AgendamentoFailure) {
            return const AlertDialog();
          } else if (state is AgendamentoSuccess) {
            return AlertDialog(
              title: const Text('Agendamento  Finalizado'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text('Agendamento finalizado com sucesso!'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fechar'),
                ),
              ],
            );
          } else {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Finalizar Agendamento'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormaPagamentoDropdown(
                        dropdownValue: formaPagamentoValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            formaPagamentoValue = newValue;
                            isFormaPagamentoValid = true;
                          });
                        },
                        hintText: 'Forma de pagamento',
                      ),
                      Visibility(
                          visible: isFormaPagamentoValid != null && !(isFormaPagamentoValid ?? true),
                          child: const Text(
                            'Selecione uma forma de pagamento',
                            style: TextStyle(color: Colors.red),
                          )),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: observacaoController,
                        decoration: const InputDecoration(labelText: 'Observação'),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Fechar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if ((isFormaPagamentoValid ?? false)) {
                          agendamentoCubit.alterarStatusAgendamento(
                            0,
                            // formaPagamento: formaPagamentoValue!,
                            // observacao: observacaoController.text,
                          );
                          // Navigator.of(context).pop();
                        } else {
                          setState(() {
                            isFormaPagamentoValid = false;
                          });
                        }
                      },
                      child: const Text('Finalizar'),
                    ),
                  ],
                );
              },
            );
          }
        },
      );
    },
  );
}
