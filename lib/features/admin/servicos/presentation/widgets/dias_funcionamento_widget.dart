import 'package:flutter/material.dart';
import 'package:la_barber/core/time_utils.dart';
import 'package:la_barber/features/admin/barbershop/repository/models/working_hour.dart';

class GroupedWorkingHoursWidget extends StatelessWidget {
  final List<WorkingHour> workingHours;

  const GroupedWorkingHoursWidget({super.key, required this.workingHours});

  @override
  Widget build(BuildContext context) {
    final groupedByDays = _groupWorkingHoursByDay(workingHours);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedByDays.entries.map((entry) {
          final day = entry.key;
          final intervals = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '${_dayOfWeekToString(day)}: ${intervals.map((interval) => '${interval['startingHour']} às ${interval['endingHour']}').join(' e ')}',
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ),
    );
  }

  Map<int, List<Map<String, String>>> _groupWorkingHoursByDay(List<WorkingHour> workingHours) {
    final Map<int, List<Map<String, String>>> groupedByDays = {};

    for (var hour in workingHours) {
      for (var day in hour.workingDays) {
        if (!groupedByDays.containsKey(day)) {
          groupedByDays[day] = [];
        }
        groupedByDays[day]!.add({
          'startingHour': TimeUtils.formatTimeToShort(hour.startingHour),
          'endingHour': TimeUtils.formatTimeToShort(hour.endingHour),
        });
      }
    }

    return groupedByDays;
  }

  String _dayOfWeekToString(int day) {
    const daysOfWeek = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    return daysOfWeek[day - 1];
  }
}
