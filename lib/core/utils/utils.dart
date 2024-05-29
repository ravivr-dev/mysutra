import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static String? getNameOrUsername(String? name, String? username) {
    if (name != null && name.isNotEmpty) {
      return name;
    }
    return username;
  }

  static bool isTodayDate(DateTime dateTime) {
    final now = DateTime.now();
    return now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year;
  }

  static void openTermsAndConditionPage() async {
    const termsAndConditionLink = 'https://mysutra.org.in/terms-of-use';
    if (await canLaunchUrl(Uri.parse(termsAndConditionLink))) {
      launchUrl(Uri.parse(termsAndConditionLink));
    }
  }

//We can make these conditions more better
  static bool isFutureTime(DateTime dateTime) {
    DateTime now = DateTime.now();

    if (dateTime.year > now.year ||
        (dateTime.year == now.year && dateTime.month > now.month) ||
        (dateTime.year == now.year &&
            dateTime.month == now.month &&
            dateTime.day > now.day)) {
      return true;
    } else if (now.day <= dateTime.day &&
        now.month <= dateTime.month &&
        now.year <= dateTime.year) {
      if (dateTime.hour > now.hour) {
        return true;
      } else if (dateTime.hour == now.hour && dateTime.minute > now.minute) {
        return true;
      }
    }
    return false;
  }

  static bool isPastTime(DateTime time) {
    final now = DateTime.now();
    if (time.year < now.year ||
        (time.year == now.year && time.month < now.month) ||
        ((time.year == now.year &&
            time.month == now.month &&
            time.day < now.day))) {
      return true;
    } else if (time.hour < now.hour ||
        (time.hour == now.hour && time.minute < now.minute)) {
      return true;
    }
    return false;
  }

  static bool isSameTime(DateTime first, DateTime second) {
    if (first.year == second.year &&
        first.month == second.month &&
        first.day == second.day) {
      return true;
    }
    return false;
  }

  static String? isValidAge(String? value) {
    final age = int.tryParse(value!);

    if (age == null) {
      return 'Please Enter Valid Age';
    } else if (age < 1) {
      return 'Age should be greater than 0';
    }
    return null;
  }
}
