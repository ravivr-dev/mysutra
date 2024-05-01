import 'package:intl/intl.dart';

class Utils {
  static String getTimeFromMinutes(int minutes) {
    int hour = minutes ~/ 60;
    int remainingMinutes = minutes - (hour * 60);
    String amPM = hour >= 12 ? 'PM' : 'AM';
    return '${changeTimeIn12HoursFormat(hour, remainingMinutes)} $amPM';
  }

  static String changeTimeIn12HoursFormat(int hours, int minutes) {
    hours = hours % 12;
    return '${'${hours == 0 ? '12' : hours}'.padLeft(2, '0')}:${'$minutes'.padLeft(2, '0')}';
  }

  static String capFirstLetter(String text) {
    return text.isNotEmpty
        ? '${text[0]}${text.substring(1).toLowerCase()}'
        : text;
  }

  static String getMonthDay(String date) {
    final dateTime = DateTime.parse(date);
    return DateFormat('MMM dd').format(dateTime);
  }
}
