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
    // Agrupar WorkDays por períodos de trabalho e intervalos
    Map<String, List<int>> periodMap = {};
    Map<String, List<int>> breakMap = {};

    for (var workDay in workDaysList) {
      if (workDay.isWork && workDay.startTime != null && workDay.endTime != null) {
        String periodKey = '${workDay.startTime}-${workDay.endTime}';
        if (!periodMap.containsKey(periodKey)) {
          periodMap[periodKey] = [];
        }
        periodMap[periodKey]!.add(workDay.numberDay);
      }

      if (workDay.isAlmoco && workDay.breakStartTime != null && workDay.breakEndTime != null) {
        String breakKey = '${workDay.breakStartTime}-${workDay.breakEndTime}';
        if (!breakMap.containsKey(breakKey)) {
          breakMap[breakKey] = [];
        }
        breakMap[breakKey]!.add(workDay.numberDay);
      }
    }

    // Criar lista de WorkingHour a partir dos mapas agrupados
    List<WorkingHour> workingHoursList = [];

    // Adicionar períodos de trabalho normais e considerar intervalos de almoço
    periodMap.forEach((key, days) {
      var times = key.split('-');
      String start = times[0];
      String end = times[1];

      bool addedNormalPeriod = false;

      // Processar intervalos de almoço
      breakMap.forEach((breakKey, breakDays) {
        var breakTimes = breakKey.split('-');
        String breakStart = breakTimes[0];
        String breakEnd = breakTimes[1];

        // Verificar se os dias de intervalo de almoço coincidem com os dias de trabalho
        List<int> overlappingDays = breakDays.where((day) => days.contains(day)).toList();
        if (overlappingDays.isNotEmpty) {
          // Adicionar período antes do intervalo de almoço
          workingHoursList.add(
            WorkingHour(
              workingDays: overlappingDays,
              startingHour: start,
              endingHour: breakStart,
            ),
          );

          // Adicionar período após o intervalo de almoço
          workingHoursList.add(
            WorkingHour(
              workingDays: overlappingDays,
              startingHour: breakEnd,
              endingHour: end,
            ),
          );

          // Remover os dias com intervalo de almoço da lista de dias normais
          days.removeWhere((day) => overlappingDays.contains(day));
        }
      });

      // Adicionar período normal para os dias restantes
      if (days.isNotEmpty) {
        workingHoursList.add(
          WorkingHour(
            workingDays: days,
            startingHour: start,
            endingHour: end,
          ),
        );
        addedNormalPeriod = true;
      }

      // Se não adicionou período normal, considerar como intervalos de almoço
      if (!addedNormalPeriod && breakMap.isEmpty) {
        workingHoursList.add(
          WorkingHour(
            workingDays: days,
            startingHour: start,
            endingHour: end,
          ),
        );
      }
    });

    return workingHoursList;
  }
}
