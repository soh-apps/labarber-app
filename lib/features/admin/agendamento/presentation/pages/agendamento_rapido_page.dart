import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:la_barber/core/ui/forma_pagamento_dropdown.dart';
import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/status_pagamento_dropdown.dart';
import 'package:la_barber/core/ui/styles/text_styles_typography.dart';
import 'package:la_barber/core/ui/widgets/caixa_selecao_servico.dart';
import 'package:la_barber/core/ui/widgets/calendario_agendamento.dart';
import 'package:la_barber/core/ui/widgets/time_picker.dart';

import 'package:la_barber/features/admin/agendamento/presentation/cubits/agendamento_cubit.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/barbershop_model.dart';
import 'package:la_barber/features/admin/servicos/repository/models/servico_model.dart';
import 'package:la_barber/features/admin/widgets/caixa_selecao_barbeiros.dart';

class AgendamentoRapidoPage extends StatefulWidget {
  final AgendamentoCubit agendamentoCubit;
  const AgendamentoRapidoPage({
    super.key,
    required this.agendamentoCubit,
  });

  @override
  State<AgendamentoRapidoPage> createState() => _AgendamentoRapidoPageState();
}

class _AgendamentoRapidoPageState extends State<AgendamentoRapidoPage> {
  final TextEditingController observacoesController = TextEditingController(text: '');
  final TextEditingController telefoneController = TextEditingController(text: '');
  final TextEditingController nomeClienteController = TextEditingController(text: '');
  String formaPagamentoValue = 'Cartão de crédito'; // Valor inicial
  String statusPagamentoDropdownValue = 'Pago'; // Valor inicial
  String barbeiroSelecionado = '';
  var dateFormat = DateFormat('dd/MM/yyyy');
  String dataSelecionada = '';
  final _formKey = GlobalKey<FormState>();
  final BarbershopModel barberShop = GetIt.I<BarbershopModel>();
  List<ServicoModel> servicosRealizados = [];
  double valorTotal = 0;
  late TimeOfDay _selectedTime;

  void _onTimeChanged(TimeOfDay newTime) {
    log(_selectedTime.toString());
    setState(() {
      _selectedTime = newTime;
    });
  }

  void _onDropdownChanged(String? newValue) {
    setState(() {
      formaPagamentoValue = newValue!;
    });
  }

  void _onStatusChanged(String? newValue) {
    if (newValue == 'Pago') {
      formaPagamentoValue = 'Cartão de crédito';
    } else {
      formaPagamentoValue = '';
    }
    setState(() {
      statusPagamentoDropdownValue = newValue!;
    });
  }

  void _onServicoChanged(int index, bool isAtivo) {
    setState(() {
      widget.agendamentoCubit.servicos[index].isAtivo = isAtivo;
      if (isAtivo) {
        servicosRealizados.add(widget.agendamentoCubit.servicos[index]);
        valorTotal += widget.agendamentoCubit.servicos[index].valor;
      } else {
        servicosRealizados.remove(widget.agendamentoCubit.servicos[index]);
        valorTotal -= widget.agendamentoCubit.servicos[index].valor;
      }
      log(servicosRealizados.length.toString());
      log('Valor Total: $valorTotal');
    });
  }

  @override
  void initState() {
    widget.agendamentoCubit.getAllInfo(barberShop.id);
    // widget.agendamentoCubit.getAllServicos(barberShop.id);
    _selectedTime = TimeOfDay.now();

    if (widget.agendamentoCubit.barbeiros.isNotEmpty) {
      barbeiroSelecionado = widget.agendamentoCubit.barbeiros.first.id!.toString(); // Ou use o atributo desejado
    }
    dataSelecionada = dateFormat.format(DateTime.now());
    log(dataSelecionada);
    super.initState();
  }

  void _onBarbeiroSelecionado(String? newValue) {
    setState(() {
      barbeiroSelecionado = newValue!;
    });
  }

  @override
  void dispose() async {
    super.dispose();
    observacoesController.dispose();
    nomeClienteController.dispose();
    telefoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double padding = 12;
    return Scaffold(
      appBar: AppBar(
        title: Text('Total: ${UtilBrasilFields.obterReal(valorTotal)}'),
        centerTitle: true,
      ),
      body: BlocBuilder<AgendamentoCubit, AgendamentoState>(
          bloc: widget.agendamentoCubit,
          builder: (context, state) {
            if (state is AgendamentoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AgendamentoFailure) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AgendamentoSuccess) {
              barbeiroSelecionado = widget.agendamentoCubit.barbeiros.first.id.toString();
              var servicos = widget.agendamentoCubit.servicos;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          ' Agendamento Rápido',
                          style: AppTextStyles.titleLarge(),
                        )),
                        const SizedBox(height: 24),
                        const Text(
                          ' Barbeiro',
                        ),
                        CaixaSelecaoBarbeiros(
                          barbeiroSelecionado: barbeiroSelecionado,
                          listaBarbeiros: widget.agendamentoCubit.barbeiros,
                          onChanged: _onBarbeiroSelecionado,
                        ),
                        const SizedBox(height: 28),
                        TextFormField(
                          onTapOutside: (_) => context.unfocus(),
                          controller: nomeClienteController,
                          decoration: const InputDecoration(
                            label: Text('Nome do Cliente'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          onTapOutside: (_) => context.unfocus(),
                          controller: telefoneController,
                          decoration: const InputDecoration(
                            label: Text('Telefone do Cliente'),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            // obrigatório
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        ),
                        SizedBox(height: padding),
                        Center(
                            child: Text(
                          ' Serviços Realizados',
                          style: AppTextStyles.titleLarge(),
                        )),
                        SizedBox(height: padding),
                        for (int index = 0; index < servicos.length; index++)
                          CaixaSelecaoServico(
                            servico: servicos[index],
                            onChanged: (bool value) {
                              _onServicoChanged(index, value);
                            },
                            isFirst: index == 0,
                            isLast: index == servicos.length - 1,
                          ),
                        SizedBox(height: padding),
                        Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            CalendarioAgendamento(
                              cancelPressed: () {
                                // setState(() {
                                //   showCalendar = false;
                                // });
                              },
                              onPressed: (DateTime value) {
                                log(dateFormat.format(value));
                                setState(() {
                                  // dateEC.text = dateFormat.format(value);
                                  // scheduleVM.deteSelecte(value);
                                  // showCalendar = false;
                                });
                              },
                              workDays: const ['1', '2'],
                            ),
                          ],
                        ),
                        SizedBox(height: padding),
                        TimePickerButton(onTimeChanged: _onTimeChanged),
                        SizedBox(height: padding),
                        const Text(' Status de Pagamento'),
                        StatusPagamentoDropdown(
                          dropdownValue: statusPagamentoDropdownValue,
                          onChanged: _onStatusChanged,
                        ),
                        SizedBox(height: padding),
                        Visibility(
                          visible: statusPagamentoDropdownValue == 'Pago',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(' Forma de pagamento'),
                              FormaPagamentoDropdown(
                                dropdownValue: formaPagamentoValue,
                                onChanged: _onDropdownChanged,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          onTapOutside: (_) => context.unfocus(),
                          controller: observacoesController,
                          decoration: const InputDecoration(
                            labelText: 'Observações',
                            alignLabelWithHint: true, // Isso alinha o label com a hint no canto superior esquerdo
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 500,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // widget.agendamentoCubit.registerAgendamento(
                              //   barbeiroSelecionado,
                              //   nomeClienteController.text,
                              //   telefoneController.text,
                              //   servicosRealizados,
                              //   dataSelecionada,
                              //   dropdownValue,
                              //   dropdownValueStatusPagamento,
                              //   observacoesController.text,
                              // );
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 0)), // Defina a largura para ocupar toda a tela
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Registrar',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
