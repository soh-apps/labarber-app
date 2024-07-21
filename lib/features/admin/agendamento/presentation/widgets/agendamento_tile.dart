import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:la_barber/core/ui/constants.dart';
import 'package:la_barber/core/ui/helpers/extensions.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:la_barber/core/utils/enums/agendamento_status_enum.dart';
import 'package:la_barber/features/admin/agendamento/repository/model/agendamento_model.dart';

class AgendamentoTile extends StatelessWidget {
  final AgendamentoModel agendamento;

  const AgendamentoTile({
    super.key,
    required this.agendamento,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushReplacementNamed(Routes.agendamentoDetail, arguments: agendamento);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorConstants.colorBrown),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AgendamentoTextRow(title: 'Data', value: DateFormat('dd/MM/yyyy').format(agendamento.data)),
            AgendamentoTextRow(title: 'Horário', value: agendamento.horario),
            AgendamentoTextRow(title: 'Cliente', value: agendamento.nomeCliente),
            AgendamentoTextRow(title: 'Serviço', value: agendamento.servicos.join(', ').toString()),
            AgendamentoTextRow(title: 'Comissao', value: 'R\$ ${agendamento.valorTotalComissao.transformaEmReal()}'),
            AgendamentoTextRow(title: 'Total', value: 'R\$ ${agendamento.valorTotal.transformaEmReal()}'),
            agendamento.status == AgendamentoStatus.realizado
                ? Column(
                    children: [
                      AgendamentoTextRow(
                          title: 'Status', value: AgendamentoStatusHelper.getStatusName(agendamento.status)),
                      AgendamentoTextRow(title: 'Forma de Pagamento', value: agendamento.formaDePagamento ?? ''),
                    ],
                  )
                : AgendamentoTextRow(title: 'Status', value: AgendamentoStatusHelper.getStatusName(agendamento.status)),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: Colors.green,
                      side: BorderSide(color: AppColor.corSecundaria)),
                  onPressed: () {
                    // Abrir um Dialog para finalizar o agendamento
                    // Nesse Dialog deve ter um dropdown para informar a forma de pagamento
                    // FormaPagamentoDropdown(
                    //   dropdownValue: formaPagamentoValue,
                    //   onChanged: _onDropdownChanged,
                    // ),
                    // Um TextformField para escrever alguma observacao
                    // Um botao para finalizar o agendamento
                    // Um botao para Fechar
                  },
                  child: const Text('FINALIZAR'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: Colors.red,
                      side: BorderSide(color: AppColor.corSecundaria)),
                  onPressed: () {
                    // Abrir um Dialog para Cancelar o agendamento
                    // Nesse Dialog deve ter uma mensagem perguntando se tem certeza que deseja cancelar o agendamento
                    // Um TextformField para escrever alguma observacao
                    // Um botao para Cancelar o agendamento
                    // Um botao para Fechar
                  },
                  child: const Text('CANCELAR'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AgendamentoTextRow extends StatelessWidget {
  final String title;
  final String value;

  const AgendamentoTextRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: '),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
