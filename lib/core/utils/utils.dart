class Utils {
  static String getTimeFromMinutes(int minutes) {
    final hour = minutes ~/ 60;
    final minute = minutes - (hour * 60);
    return '${'$hour'.padLeft(2, '0')}:${'$minute'.padLeft(2, '0')} ${hour < 12 ? 'AM' : 'PM'}';
  }

  static String capFirstLetter(String text) {
    return text.isNotEmpty
        ? '${text[0]}${text.substring(1).toLowerCase()}'
        : text;
  }
}
