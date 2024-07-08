import 'package:flutter/material.dart';
import 'package:la_barber/core/ui/styles/app_color.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioAgendamento extends StatefulWidget {
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> onPressed;
  final List<String> workDays;

  const CalendarioAgendamento({
    super.key,
    required this.cancelPressed,
    required this.onPressed,
    required this.workDays,
  });

  @override
  State<CalendarioAgendamento> createState() => _CalendarioAgendamentoState();
}

class _CalendarioAgendamentoState extends State<CalendarioAgendamento> {
  DateTime? selectedDay;
  late final List<int> weekDaysEnabled;

  int convertWeekDay(String weekDay) => switch (weekDay.toLowerCase()) {
        'seg' => DateTime.monday,
        'ter' => DateTime.tuesday,
        'qua' => DateTime.wednesday,
        'qui' => DateTime.thursday,
        'sex' => DateTime.friday,
        'sab' => DateTime.saturday,
        'dom' => DateTime.sunday,
        _ => 0,
      };

  @override
  void initState() {
    super.initState();

    // weekDaysEnabled = widget.workDays.map(convertWeekDay).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffe6e2e9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TableCalendar(
              availableGestures: AvailableGestures.none,
              headerStyle: const HeaderStyle(titleCentered: true),
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2015, 01, 01),
              lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
              calendarFormat: CalendarFormat.month,
              locale: 'pt_BR',
              availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
              // enabledDayPredicate: (day) {
              //   return weekDaysEnabled.contains(day.weekday);
              // },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                widget.onPressed(selectedDay);
                setState(() {
                  this.selectedDay = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(color: AppColor.corSecundaria, shape: BoxShape.circle),
                  todayDecoration:
                      BoxDecoration(color: AppColor.corSecundaria.withOpacity(0.4), shape: BoxShape.circle))),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: widget.cancelPressed,
          //       child: Text(
          //         'Cancelar',
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500,
          //           color: AppColor.corSecundaria,
          //         ),
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         if (selectedDay == null) {
          //           context.showError('Por favor selecione um dia');
          //           return;
          //         }
          //         widget.onPressed(selectedDay!);
          //       },
          //       child: Text(
          //         'OK',
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           color: AppColor.corSecundaria,
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
