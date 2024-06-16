import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/formatters.dart';
import 'package:la_barber/core/ui/app_color.dart';
import 'package:la_barber/features/admin/barbershop/repository/entities/work_days.dart';
import 'package:validatorless/validatorless.dart';

import 'package:la_barber/core/ui/helpers/form_helper.dart';
import 'package:la_barber/core/ui/helpers/messages.dart';
import 'package:la_barber/core/ui/widgets/weekdays_panel.dart';
import 'package:la_barber/features/admin/barbershop/presentation/cubit/barbershop_cubit.dart';

class BarbershopRegisterPage extends StatefulWidget {
  final BarbershopCubit barbershopCubit;

  const BarbershopRegisterPage({
    super.key,
    required this.barbershopCubit,
  });

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nomeEC = TextEditingController();
  final telefoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final numeroEC = TextEditingController();
  String diaSemanaString = '';

  @override
  void dispose() {
    nomeEC.dispose();
    telefoneEC.dispose();
    cepEC.dispose();
    numeroEC.dispose();
    super.dispose();
  }

  bool horarioAlmoco = true;
  bool visibleHorarioAbertura = true;
  List<WorkDays> openingDays = [];

  TimeOfDay _horaAbertura = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay _horaFechamento = const TimeOfDay(hour: 20, minute: 00);
  TimeOfDay? _horaInicioAlmoco = const TimeOfDay(hour: 12, minute: 00);
  TimeOfDay? _horaFimAlmoco = const TimeOfDay(hour: 13, minute: 00);

  Future<void> _selectTime(BuildContext context, TimeOfDay? initialTime, ValueChanged<TimeOfDay?> onTimeChanged) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != initialTime) {
      setState(() {
        onTimeChanged(picked);
      });
    }
  }

  void _selectOpeningTime(BuildContext context, int weekDayNumber, String type) async {
    WorkDays? selectedDay = openingDays.firstWhere((day) => day.numberDay == weekDayNumber,
        orElse: () => WorkDays(numberDay: weekDayNumber));
    TimeOfDay? initialTime;

    if (type == 'start') {
      initialTime = selectedDay.startTime != null
          ? TimeOfDay(
              hour: int.parse(selectedDay.startTime!.split(":")[0]),
              minute: int.parse(selectedDay.startTime!.split(":")[1]))
          : const TimeOfDay(hour: 8, minute: 00);
    } else {
      initialTime = selectedDay.endTime != null
          ? TimeOfDay(
              hour: int.parse(selectedDay.endTime!.split(":")[0]),
              minute: int.parse(selectedDay.endTime!.split(":")[1]))
          : const TimeOfDay(hour: 20, minute: 00);
    }

    await _selectTime(context, initialTime, (time) {
      if (time != null) {
        setState(() {
          String formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
          if (type == 'start') {
            selectedDay.startTime = formattedTime;
          } else {
            selectedDay.endTime = formattedTime;
          }
          openingDays = openingDays.where((day) => day.numberDay != weekDayNumber).toList();
          openingDays.add(selectedDay);
        });
      }
    });
  }

  void addOpenDay(String weekDay) {
    int weekDayNumber = Formatters.getNumberDayofWeek(weekDay);
    if (weekDayNumber != 0) {
      bool alreadyExists = openingDays.any((day) => day.numberDay == weekDayNumber);
      if (!alreadyExists) {
        setState(() {
          openingDays.add(WorkDays(numberDay: weekDayNumber, isWork: true, startTime: '08:00', endTime: '20:00'));
          diaSemanaString = weekDay;
        });
        log(openingDays.map((e) => e.numberDay).toList().toString());
      } else {
        setState(() {
          // Find the existing WorkDays for the selected day
          WorkDays selectedDay = openingDays.firstWhere((day) => day.numberDay == weekDayNumber);
          // Update _horaAbertura and _horaFechamento with the values from selectedDay
          _horaAbertura = TimeOfDay(
              hour: int.parse(selectedDay.startTime!.split(":")[0]),
              minute: int.parse(selectedDay.startTime!.split(":")[1]));
          _horaFechamento = TimeOfDay(
              hour: int.parse(selectedDay.endTime!.split(":")[0]),
              minute: int.parse(selectedDay.endTime!.split(":")[1]));
          diaSemanaString = weekDay;
        });
        log('Dia da semana já selecionado');
      }
    } else {
      log('Erro ao selecionar dia da semana');
    }
  }

  void removeOpenDay(String weekDay) {
    int weekDayNumber = Formatters.getNumberDayofWeek(weekDay);
    if (weekDayNumber != 0) {
      setState(() {
        openingDays.removeWhere((day) => day.numberDay == weekDayNumber);
        diaSemanaString = weekDay;
      });
      log(openingDays.map((e) => e.numberDay).toList().toString());
    } else {
      log('Erro ao selecionar dia da semana');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarbershopCubit, BarbershopState>(
      bloc: widget.barbershopCubit,
      listener: (context, state) {
        // if (state is AuthStateError) {
        //   context.showError(state.errorMessage);

        //   context.hideLoadingDialog(context); // Pop dialog
        // } else if (state is AuthStateSuccess) {
        //   // hideLoadingDialog(context); // Pop dialog
        //   context.showSuccess('Deu certo o Login');
        //   Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
        // } else if (state is AuthStateLoaging) {
        //   context.showLoadingDialog(context, message: "Loading");

        //   //  BarbershopLoader();
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cradastrar estabelecimento'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nomeEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: telefoneEC,
                  validator: Validatorless.required('Telefone obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: cepEC,
                  validator: Validatorless.required('Cep obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('CEP'),
                  ),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: numeroEC,
                  validator: Validatorless.required('Número obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Número'),
                  ),
                ),
                const SizedBox(height: 24),
                WeekdaysPanel(
                  onDayPressed: (String value) {
                    addOpenDay(value);
                    setState(() {
                      visibleHorarioAbertura = true;
                    });
                  },
                  openingDays: openingDays.map((e) => e.numberDay).toList(),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: visibleHorarioAbertura,
                  child: Column(
                    children: [
                      Text('Horários de atendimento para o dia selecionado $diaSemanaString'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TimeDisplay(
                            label: 'Abertura',
                            time: openingDays
                                        .firstWhere(
                                            (day) => day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString),
                                            orElse: () => WorkDays(numberDay: 0))
                                        .startTime !=
                                    null
                                ? TimeOfDay(
                                    hour: int.parse(openingDays
                                        .firstWhere(
                                            (day) => day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString))
                                        .startTime!
                                        .split(":")[0]),
                                    minute: int.parse(openingDays
                                        .firstWhere(
                                            (day) => day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString))
                                        .startTime!
                                        .split(":")[1]))
                                : _horaAbertura,
                            onSelectTime: () =>
                                _selectOpeningTime(context, Formatters.getNumberDayofWeek(diaSemanaString), 'start'),
                          ),
                          TimeDisplay(
                            label: 'Fechamento',
                            time: openingDays
                                        .firstWhere(
                                            (day) => day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString),
                                            orElse: () => WorkDays(numberDay: 0))
                                        .endTime !=
                                    null
                                ? TimeOfDay(
                                    hour: int.parse(openingDays
                                        .firstWhere(
                                            (day) => day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString))
                                        .endTime!
                                        .split(":")[0]),
                                    minute: int.parse(openingDays
                                        .firstWhere(
                                            (day) => day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString))
                                        .endTime!
                                        .split(":")[1]))
                                : _horaFechamento,
                            onSelectTime: () =>
                                _selectOpeningTime(context, Formatters.getNumberDayofWeek(diaSemanaString), 'end'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomCheckbox(
                        value: horarioAlmoco,
                        label: 'Adicionar horário de almoço',
                        onChanged: (value) {
                          setState(() {
                            horarioAlmoco = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Visibility(
                  visible: horarioAlmoco,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimeDisplay(
                        label: 'Início',
                        time: _horaInicioAlmoco,
                        onSelectTime: () => _selectTime(context, _horaInicioAlmoco, (time) => _horaInicioAlmoco = time),
                      ),
                      TimeDisplay(
                        label: 'Fim',
                        time: _horaFimAlmoco,
                        onSelectTime: () => _selectTime(context, _horaFimAlmoco, (time) => _horaFimAlmoco = time),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      removeOpenDay(diaSemanaString);
                      diaSemanaString = '';
                      horarioAlmoco = false;
                      visibleHorarioAbertura = false;
                    },
                    child: const Text('REMOVER DIA'),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          context.showError('Formulário invalido');
                        case true:
                        // barbershopRegisterVM.register(
                        //     name: nameEC.text,
                        //     email: emailEC.text,
                        // );
                      }
                    },
                    child: const Text('CADASTRAR ESTABELECIMENTO'),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class TimeDisplay extends StatelessWidget {
  final String label;
  final TimeOfDay? time;
  final VoidCallback onSelectTime;

  const TimeDisplay({
    super.key,
    this.label = '',
    required this.time,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(visible: label.isNotEmpty, child: Text(label)),
        GestureDetector(
          onTap: onSelectTime,
          child: Container(
            width: 64,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: AppColor.corSecundaria,
              ),
            ),
            child: Center(
              child: Text(
                time == null ? '---' : ' ${time!.format(context)}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.corSecundaria,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
