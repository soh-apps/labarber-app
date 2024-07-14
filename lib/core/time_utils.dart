import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  // Transforma "HH:mm:ss" em "HH:mm"
  static String formatTimeToShort(String time) {
    try {
      final DateFormat inputFormat = DateFormat('HH:mm:ss');
      final DateFormat outputFormat = DateFormat('HH:mm');
      final DateTime parsedTime = inputFormat.parse(time);
      return outputFormat.format(parsedTime);
    } catch (e) {
      throw const FormatException('Invalid time format');
    }
  }

  // Transforma "HH:mm" em "HH:mm:ss"
  static String formatTimeToLong(String time) {
    try {
      final DateFormat inputFormat = DateFormat('HH:mm');
      final DateFormat outputFormat = DateFormat('HH:mm:ss');
      final DateTime parsedTime = inputFormat.parse(time);
      return outputFormat.format(parsedTime);
    } catch (e) {
      throw const FormatException('Invalid time format');
    }
  }
}
