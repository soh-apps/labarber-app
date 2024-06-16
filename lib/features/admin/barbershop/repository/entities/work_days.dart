class WorkDays {
  int numberDay;
  bool isWork;
  String? startTime;
  String? endTime;
  String? breakStartTime;
  String? breakEndTime;

  WorkDays({
    required this.numberDay,
    this.isWork = false,
    this.startTime,
    this.endTime,
    this.breakStartTime,
    this.breakEndTime,
  });
}
