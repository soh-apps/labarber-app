import 'package:intl/intl.dart';

class Formatters {
  static int parseInt(dynamic value) {
    try {
      if (value == null) {
        return 0;
      }
      if (value is int) {
        return value;
      }
      if (value is double) {
        return value.toInt();
      }
      if (value is String) {
        return int.parse(value);
      }
    } catch (_) {}
    return 0;
  }

  static String parseString(dynamic value) {
    try {
      if (value == null) {
        return '';
      }
      if (value is String) {
        return value;
      }
      if (value is double) {
        return value.toString();
      }
      if (value is int) {
        return value.toString();
      }
    } catch (_) {
      return '';
    }
    return '';
  }

  static double parseDouble(dynamic value) {
    if (value == null) {
      return 0;
    }
    if (value is String) {
      return double.parse(value);
    }
    if (value is double) {
      return value;
    }
    if (value is int) {
      return value.toDouble();
    }
    return 0;
  }

  static bool parseBool(dynamic value) {
    if (value == null) {
      return false;
    }
    if (value is bool) {
      return value;
    }
    return false;
  }

  static String dateTimeString(DateTime value) {
    try {
      return DateFormat('dd-MM-yyyy – HH:mm').format(value);
    } catch (e) {
      return '';
    }
  }

  static String dateTimeBarString(DateTime value) {
    try {
      return DateFormat('dd/MM/yyyy – HH:mm').format(value);
    } catch (e) {
      return '';
    }
  }

  static String dateTimeStringAPI(DateTime value) {
    try {
      return DateFormat('dd/MM/yyyy').format(value);
    } catch (e) {
      return '';
    }
  }

  static String dateTimeStringAbbreviatedMonth(DateTime value) {
    try {
      return DateFormat('dd MMM yyyy', 'pt_br').format(value);
    } catch (e) {
      return '';
    }
  }

  static String dateTimeStringPayments(DateTime value) {
    try {
      return DateFormat('yyyy-MM-ddTHH:mm:ss').format(value);
    } catch (e) {
      return '';
    }
  }

  static String dateTimeWithoutHourString(DateTime value) {
    try {
      return DateFormat('yyyy-MM-dd').format(value);
    } catch (e) {
      return '';
    }
  }

  static String dateTimeWithoutHourStringInDDMMYYY(DateTime value) {
    try {
      return DateFormat('dd/MM/yyyy').format(value);
    } catch (e) {
      return '';
    }
  }

  static DateTime? dateTimeStringTimeServer(String value) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(value);
    } catch (e) {
      return null;
    }
  }

  static DateTime dateTimeStringDateServer(String value) {
    try {
      return DateFormat('yyyy-MM-dd').parse(value);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String stringTimeZoneToString(String value) {
    try {
      return Formatters.dateTimeStringAPI(
        Formatters.stringTimeZoneToDateTime(
          value,
        ),
      );
    } catch (e) {
      return '';
    }
  }

  static DateTime stringToDateTime(String value) {
    try {
      return DateFormat('dd/MM/yyyy').parse(value);
    } catch (e) {
      return DateTime.now();
    }
  }

  static DateTime stringToDateTimehhmm(String value) {
    try {
      return DateFormat('dd/MM/yyyy hh:mm').parse(value);
    } catch (e) {
      return DateTime.now();
    }
  }

  static DateTime stringDateTimeToDateTime(String value) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(value);
    } catch (e) {
      return DateTime.now();
    }
  }

  static DateTime stringTimeZoneToDateTime(String value) {
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(value);
    } catch (e) {
      return DateTime.now();
    }
  }

  static DateTime stringTimeZoneToDateTimeCertificate(String value) {
    try {
      return DateFormat('dd/MM/yyyy')
          .parse(DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(value)));
    } catch (e) {
      return DateTime.now();
    }
  }

  static String extractDDD(String value) {
    if (value.length >= 2) {
      return value[1] + value[2];
    } else {
      return '';
    }
  }

  static String extractPhoneFromDDD(String value) {
    if (value.isNotEmpty && value.length > 5) {
      return value.substring(5, value.length);
    }
    return '';
  }

  static String extractPhoneWithoutSpecialChars(String value) {
    return value.replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '').replaceAll('-', '');
  }

  static String extractNumbersFromCPF(String value) {
    return value.replaceAll('-', '').replaceAll('.', '');
  }

  static String currency(double value) {
    String currencySymbol = "R\$";

    if (value < 0) {
      value = -value;
      currencySymbol = "- R\$";
    }

    final formatter = NumberFormat("###,##0.00", "pt-br").format(value);
    return "$currencySymbol $formatter";
  }

  static String formatCEP(String cep) {
    if (cep.length == 8) {
      return '${cep.substring(0, 5)}-${cep.substring(5, cep.length)}';
    }
    return cep;
  }

  static String formatPhone(String? ddd, String? phone, {bool withHyphen = false}) {
    if (withHyphen) {
      if (ddd != null && ddd.isNotEmpty && phone != null && phone.isNotEmpty) {
        return '($ddd) ${phone.substring(0, phone.length == 9 ? 5 : 4)}-${phone.substring(phone.length == 9 ? 5 : 4, phone.length)}';
      }
    } else {
      if (ddd != null && ddd.isNotEmpty && phone != null && phone.isNotEmpty) {
        return '($ddd) $phone';
      }
    }
    return '';
  }

  static String formatCPF(String? cpf) {
    if (cpf != null && cpf.length == 11) {
      return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, cpf.length)}';
    }
    return '';
  }

  static String? cutTheText(String? text, int size) {
    if (text != null && text.length >= size) {
      text = text.substring(0, size);
    }
    return text;
  }

  static String? removeLeftZero(String? text) {
    final RegExp regexp = RegExp(r'^0+(?=.)');
    if (text != null) {
      return text.replaceAll(regexp, '');
    } else {
      return '';
    }
  }

  static String? extractProductFromCapitalizationnCertificate(String capitalizationCertificate) {
    return capitalizationCertificate.substring(0, 2);
  }

  static String? extractSerialFromCapitalizationnCertificate(String capitalizationCertificate) {
    return capitalizationCertificate.substring(2, 6);
  }

  static String? extractNumberFromCapitalizationnCertificate(String capitalizationCertificate) {
    return capitalizationCertificate.substring(6, 13);
  }

  static String? extractDvFromCapitalizationnCertificate(String capitalizationCertificate) {
    return capitalizationCertificate.substring(13, 14);
  }

  static String onlyNumbers(String value) {
    return value.replaceAll(RegExp(r'[^\d]'), '');
  }

  static String toDecimalPattern(String value) {
    int count = 0;
    List<String> aux = [];
    for (int i = value.split('').length - 1; i >= 0; i--) {
      if (count == 3) {
        aux.add('.');
        count = 0;
      }
      aux.add(value.split('')[i]);

      count++;
    }
    return aux.reversed.join();
  }

  static String leftZeros(String number, int quantityZero) {
    return number.padLeft(quantityZero, '0');
  }

  static String secondsToHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static String greetings(String hour) {
    if (parseInt(hour) >= 18 || parseInt(hour) < 6) {
      return 'Boa noite';
    } else if (parseInt(hour) >= 6 && parseInt(hour) < 12) {
      return 'Bom dia';
    } else {
      return 'Boa tarde';
    }
  }

  static String capitalizeWords(String? text) {
    final pieces = text?.trim().split(' ');
    final capitalizedPieces = pieces?.map((word) {
          return word.toCapitalized();
        }).toList() ??
        [];
    return capitalizedPieces.join(' ');
  }

  static String getMonth(String month) {
    switch (parseInt(month)) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return '';
    }
  }

  static String getMonthAbreviation(String month) {
    switch (parseInt(month)) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEV';
      case 3:
        return 'MAR';
      case 4:
        return 'ABR';
      case 5:
        return 'MAI';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AGO';
      case 9:
        return 'SET';
      case 10:
        return 'OUT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEZ';
      default:
        return '';
    }
  }

  static String lastCellPhoneNumber(String cellPhone) {
    if (cellPhone.isNotEmpty) {
      return cellPhone.substring(cellPhone.length - 4);
    } else {
      return '';
    }
  }

  static String getDayofWeek(int dayOfWeek) {
    try {
      // final dateParts = brFormatDate.split('/');

      // final dateObject = DateTime(
      //   parseInt(dateParts[2]),
      //   parseInt(dateParts[1]),
      //   parseInt(dateParts[0]),
      // );
      // final dayOfWeek = dateObject.weekday;
      switch (dayOfWeek) {
        case 2:
          return 'Segunda';
        case 3:
          return 'Terça';
        case 4:
          return 'Quarta';
        case 5:
          return 'Quinta';
        case 6:
          return 'Sexta';
        case 7:
          return 'Sábado';
        case 1:
          return 'Domingo';
        default:
          return '';
      }
    } catch (error) {
      return '';
    }
  }
  // static String getDayofWeek(String brFormatDate) {
  //   try {
  //     final dateParts = brFormatDate.split('/');

  //     final dateObject = DateTime(
  //       parseInt(dateParts[2]),
  //       parseInt(dateParts[1]),
  //       parseInt(dateParts[0]),
  //     );
  //     final dayOfWeek = dateObject.weekday;
  //     switch (dayOfWeek) {
  //       case 1:
  //         return 'Segunda';
  //       case 2:
  //         return 'Terça';
  //       case 3:
  //         return 'Quarta';
  //       case 4:
  //         return 'Quinta';
  //       case 5:
  //         return 'Sexta';
  //       case 6:
  //         return 'Sábado';
  //       case 7:
  //         return 'Domingo';
  //       default:
  //         return '';
  //     }
  //   } catch (error) {
  //     return '';
  //   }
  // }

  static String formatSecondsToHHMMSS(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String formatSecondsToMMSS(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static String parseStringAndReplaceSpace(dynamic value) {
    try {
      if (value == null) {
        return '';
      }
      if (value is String) {
        return value.replaceAll(RegExp(r'<br>', caseSensitive: false), '\n');
      }
      if (value is double) {
        return value.toString().replaceAll(RegExp(r'<br>', caseSensitive: false), '\n');
      }
      if (value is int) {
        return value.toString().replaceAll(RegExp(r'<br>', caseSensitive: false), '\n');
      }
    } catch (_) {
      return '';
    }
    return '';
  }

  String substituirQuebrasDeLinha(String texto) {
    return texto.replaceAll(RegExp(r'<br>', caseSensitive: false), '\n');
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
