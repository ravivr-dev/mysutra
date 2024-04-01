import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import 'package:intl/intl.dart';

extension MainNavigationPath on BuildContext {
  void navigateToUpdatedPortfolio() {
    AiloitteNavigation.intentWithClearAllRoutes(this, AppRoutes.splashRoutes);
  }

  void navigateToUpdatedHome() {
    AiloitteNavigation.intentWithClearAllRoutes(this, AppRoutes.splashRoutes);
  }

  String getProfileNameInitials({
    required String firstName,
    required String lastName,
  }) {
    final String name =
        "${firstName.split('').first.toUpperCase()} ${lastName.split('').first.toUpperCase()}";

    return name;
  }

  bool hasValidUrl(String value) {
    if (value.isEmpty) {
      return false;
    }
    const String pattern =
        "(www.)?[a-zA-Z0-9@:%._\\+~#?&//=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%._\\+~#?&//=]*)";
    final RegExp regExp = RegExp(pattern);
    return !regExp.hasMatch(value);
  }

  void openKeyboard(FocusNode inputNode) {
    FocusScope.of(this).requestFocus(inputNode);
  }

  String getTimeAndPlace(String? city, DateTime? startDateTime) {
    final String date =
        DateFormat('dd MMMM, yyyy').format(startDateTime ?? DateTime.now());

    final String formattedTime =
        DateFormat().add_jm().format(startDateTime ?? DateTime.now());

    return '$city $date - $formattedTime';
  }

  DateTime formattedDateTimeForCreateEvent(
    DateTime? date,
  ) {
    return DateTime(
      date?.year ?? DateTime.now().year,
      date?.month ?? DateTime.now().month,
      date?.day ?? DateTime.now().day,
      date?.hour ?? DateTime.now().hour,
      date?.minute ?? DateTime.now().minute,
    );
  }

  String getInitialFromFullName(String? name) {
    String splitedName = "";
    if (name != null && name.trim().isNotEmpty) {
      final List<String> s = name.trim().split(RegExp('\\s+'));
      if (s.length > 1) {
        splitedName =
            "${s[0].trim()[0].toUpperCase()}${s[s.length - 1].trim()[0].toUpperCase()}";
      } else {
        splitedName = s[0].trim()[0].toUpperCase();
      }
    }

    return splitedName;
  }

  String durationToString(int minutes) {
    final duration = Duration(minutes: minutes);
    final List<String> parts = duration.toString().split(':');
    debugPrint(parts[1]);
    if (parts[0].length == 2) {
      return '${parts[0].padLeft(2, '0')}h ${parts[1] == '00' ? '' : parts[1].padLeft(2, '0')} ${parts[1] == '00' ? '' : 'm'}';
    } else {
      return '${parts[0].padLeft(1, '0')}h ${parts[1] == '00' ? '' : parts[1].padLeft(2, '0')} ${parts[1] == '00' ? '' : 'm'}';
    }
  }
}
