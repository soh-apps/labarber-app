import 'package:la_barber/features/admin/barbershop/repository/models/working_hour.dart';

class WorkDays {
  int numberDay;
  bool isWork;
  bool isAlmoco;
  String? startTime;
  String? endTime;
  String? breakStartTime;
  String? breakEndTime;

  WorkDays({
    required this.numberDay,
    this.isWork = false,
    this.isAlmoco = false,
    this.startTime,
    this.endTime,
    this.breakStartTime,
    this.breakEndTime,
  });

  // Método para converter lista de WorkDays em lista de WorkingHour
  static List<WorkingHour> convertWorkDaysToWorkingHours(List<WorkDays> workDaysList) {
    // Agrupar WorkDays por períodos de trabalho
    Map<String, List<int>> periodMap = {};
    for (var workDay in workDaysList) {
      if (workDay.isWork && workDay.startTime != null && workDay.endTime != null) {
        String periodKey = '${workDay.startTime}-${workDay.endTime}';
        if (!periodMap.containsKey(periodKey)) {
          periodMap[periodKey] = [];
        }
        periodMap[periodKey]!.add(workDay.numberDay);
      }
    }

    // Criar lista de WorkingHour a partir do mapa agrupado
    List<WorkingHour> workingHoursList = [];
    periodMap.forEach((key, value) {
      var times = key.split('-');
      workingHoursList.add(
        WorkingHour(
          workingDays: value,
          startingHour: times[0],
          endingHour: times[1],
        ),
      );
    });

    return workingHoursList;
  }
}
