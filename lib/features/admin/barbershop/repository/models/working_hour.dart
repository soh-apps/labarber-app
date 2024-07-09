class WorkingHour {
  List<int> workingDays;
  String startingHour;
  String endingHour;

  WorkingHour({
    required this.workingDays,
    required this.startingHour,
    required this.endingHour,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    return WorkingHour(
      workingDays: List<int>.from(json['workingDays']),
      startingHour: json['startingHour'],
      endingHour: json['endingHour'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workingDays': workingDays,
      'startingHour': '$startingHour:00',
      'endingHour': '$endingHour:00',
    };
  }
}
