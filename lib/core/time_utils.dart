import 'package:flutter/material.dart';

class TimeUtils {
  // Função para obter a hora de uma string no formato HH:mm
  static int getHourFromTimeString(String timeString) {
    return int.parse(timeString.split(":")[0]);
  }

  // Função para obter o minuto de uma string no formato HH:mm
  static int getMinuteFromTimeString(String timeString) {
    return int.parse(timeString.split(":")[1]);
  }

  // Função para obter um objeto TimeOfDay de uma string no formato HH:mm
  static TimeOfDay getTimeOfDayFromString(String timeString) {
    final int hour = getHourFromTimeString(timeString);
    final int minute = getMinuteFromTimeString(timeString);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
