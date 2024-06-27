import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_barber/core/formatters.dart';
import 'package:la_barber/core/time_utils.dart';
import 'package:la_barber/core/ui/helpers/context_extension.dart';
import 'package:la_barber/core/ui/widgets/custom_check_box.dart';
import 'package:la_barber/core/ui/widgets/image_picker.dart';
import 'package:la_barber/features/admin/barbershop/presentation/widgets/time_display.dart';
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

  @override
  void dispose() {
    nomeEC.dispose();
    telefoneEC.dispose();
    cepEC.dispose();
    numeroEC.dispose();
    super.dispose();
  }

  String diaSemanaString = '';
  bool isHorarioAlmoco = false;
  bool visibleHorarioAbertura = false;
  List<WorkDays> openingDays = [];
  File? _selectedImage;

  TimeOfDay _horaAbertura = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay _horaFechamento = const TimeOfDay(hour: 20, minute: 00);
  TimeOfDay? _horaInicioAlmoco = const TimeOfDay(hour: 12, minute: 00);
  TimeOfDay? _horaFimAlmoco = const TimeOfDay(hour: 13, minute: 00);

  void _onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

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
          ? TimeUtils.getTimeOfDayFromString(selectedDay.startTime!)
          : const TimeOfDay(hour: 8, minute: 00);
    } else {
      initialTime = selectedDay.endTime != null
          ? TimeUtils.getTimeOfDayFromString(selectedDay.startTime!)
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

  void _selectBreakTime(BuildContext context, int weekDayNumber, String type) async {
    WorkDays? selectedDay = openingDays.firstWhere((day) => day.numberDay == weekDayNumber,
        orElse: () => WorkDays(numberDay: weekDayNumber));
    TimeOfDay? initialTime;

    if (type == 'breakStart') {
      initialTime = selectedDay.breakStartTime != null
          ? TimeUtils.getTimeOfDayFromString(selectedDay.startTime!)
          : const TimeOfDay(hour: 12, minute: 00);
    } else {
      initialTime = selectedDay.breakEndTime != null
          ? TimeUtils.getTimeOfDayFromString(selectedDay.startTime!)
          : const TimeOfDay(hour: 13, minute: 00);
    }

    await _selectTime(context, initialTime, (time) {
      if (time != null) {
        setState(() {
          String formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
          if (type == 'breakStart') {
            selectedDay.breakStartTime = formattedTime;
            _horaInicioAlmoco = time;
          } else {
            selectedDay.breakEndTime = formattedTime;
            _horaFimAlmoco = time;
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
          isHorarioAlmoco = false;
          openingDays.add(WorkDays(
            numberDay: weekDayNumber,
            isWork: true,
            startTime: '08:00',
            endTime: '20:00',
            isAlmoco: false,
          ));
          diaSemanaString = weekDay;
        });
        log(openingDays.map((e) => e.numberDay).toList().toString());
      } else {
        setState(() {
          WorkDays selectedDay = openingDays.firstWhere((day) => day.numberDay == weekDayNumber);
          _horaAbertura = TimeOfDay(
              hour: TimeUtils.getHourFromTimeString(selectedDay.startTime!),
              minute: TimeUtils.getMinuteFromTimeString(selectedDay.startTime!));
          _horaFechamento = TimeOfDay(
              hour: TimeUtils.getHourFromTimeString(selectedDay.endTime!),
              minute: TimeUtils.getMinuteFromTimeString(selectedDay.endTime!));
          if (selectedDay.isAlmoco) {
            isHorarioAlmoco = true;
            _horaInicioAlmoco = TimeOfDay(
                hour: TimeUtils.getHourFromTimeString(selectedDay.breakStartTime!),
                minute: TimeUtils.getMinuteFromTimeString(selectedDay.breakStartTime!));
            _horaFimAlmoco = TimeOfDay(
                hour: TimeUtils.getHourFromTimeString(selectedDay.breakEndTime!),
                minute: TimeUtils.getMinuteFromTimeString(selectedDay.breakEndTime!));
          } else {
            _horaInicioAlmoco = null;
            _horaFimAlmoco = null;
          }
          isHorarioAlmoco = selectedDay.isAlmoco;
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

  void checkBoxAlmoco(bool value) {
    openingDays = openingDays.map((day) {
      if (day.numberDay == Formatters.getNumberDayofWeek(diaSemanaString)) {
        if (value) {
          day.isAlmoco = true;
          day.breakStartTime = '12:00';
          day.breakEndTime = '13:00';
          setState(() {
            isHorarioAlmoco = value;
            _horaInicioAlmoco = TimeUtils.getTimeOfDayFromString(day.breakStartTime!);
            _horaFimAlmoco = TimeUtils.getTimeOfDayFromString(day.breakEndTime!);
          });
        } else {
          day.isAlmoco = false;
          day.breakStartTime = null;
          day.breakEndTime = null;
        }
        setState(() {
          isHorarioAlmoco = value;
        });
      }

      return day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarbershopCubit, BarbershopState>(
      bloc: widget.barbershopCubit,
      listener: (context, state) {
        if (state is BarbershopSuccess) {
          context.hideLoadingDialog(context);
          context.showSuccess('Unidade Cadastrada com Sucesso!');
          context.pop();
        } else if (state is BarbershopLoading) {
          context.showLoadingDialog(context);
        } else if (state is BarbershopFailure) {
          context.hideLoadingDialog(context);
          context.showError(state.errorMessage);
        }
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
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                Center(
                  child: ImagePickerWidget(
                    imageUrl: null,
                    onImageSelected: _onImageSelected,
                  ),
                ),
                const SizedBox(height: 20),
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
                      const SizedBox(height: 4),
                      Visibility(
                        visible: isHorarioAlmoco,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TimeDisplay(
                              label: 'Início',
                              time: _horaInicioAlmoco,
                              onSelectTime: () => _selectBreakTime(
                                  context, Formatters.getNumberDayofWeek(diaSemanaString), 'breakStart'),
                            ),
                            TimeDisplay(
                              label: 'Fim',
                              time: _horaFimAlmoco,
                              onSelectTime: () =>
                                  _selectBreakTime(context, Formatters.getNumberDayofWeek(diaSemanaString), 'breakEnd'),
                            ),
                          ],
                        ),
                      ),
                      CustomCheckbox(
                        value: isHorarioAlmoco,
                        label: 'Adicionar horário de almoço',
                        onChanged: (value) {
                          checkBoxAlmoco(value ?? false);
                        },
                      ),
                      const SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 34),
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                          onPressed: () {
                            removeOpenDay(diaSemanaString);
                            diaSemanaString = '';
                            isHorarioAlmoco = false;
                            visibleHorarioAbertura = false;
                          },
                          child: const Text('REMOVER DIA'),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          context.showError('Formulário invalido');
                        case true:
                          log(_selectedImage.toString());
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
