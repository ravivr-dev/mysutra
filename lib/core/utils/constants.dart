// ignore_for_file: constant_identifier_names

// import 'package:flutter/services.dart';

class Constants {
  static const String appName = "MySutra";

  static const String authorization = "Authorization";

  static const tempNetworkUrl =
      "https://source.unsplash.com/random?profile-picture";

  static const serverDateFormat = "yyyy-MM-dd";

  static const errorInternet = "Your internet is not working it seems";
  static const String errorNoInternet = "No internet available";
  static const String errorDataFound = "No Data Found";
  static const String errorDataNotCreated = "No Data Created";
  static const String noDataFound = "No Data Found";
  static const String errorUnknown = "Unknown error occurred";
  static const String errorTypeServer = "Server Error";
  static const String errorTypeTimeout = "Time Out";

  static const String baseUrl =
      "http://mysutra-dev.ap-south-1.elasticbeanstalk.com";

  //Patient Constants
  static const String id = '_id';
  static const String day = 'day';
  static const String slotType = 'slotType';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
  static const String userName = 'username';
  static const String profilePic = 'profilePic';
  static const String countryCode = 'countryCode';
  static const String phoneNumber = 'phoneNumber';
  static const String date = 'date';
  static const String time = 'time';
  static const String timeInMinutes = 'timeInMinutes';
  static const String message = 'message';
  static const String count = 'count';
  static const String data = 'data';

  //User Constants
  static const String user = 'user';
  static const String role = 'role';
  static const String fullName = 'fullName';
  static const String isVerified = 'isVerified';
  static const String specialization = 'specialization';
  static const String totalExperience = 'totalExperience';
  static const String totalFollowers = 'totalFollowers';
  static const String email = 'email';
  static const String fees = 'fees';
  static const String about = 'about';

  //Doctor Constants
  static const String userId = 'userId';

//
}

class DateTimeUtils {
  static bool leapYear(DateTime date) {
    if (date.year % 4 == 0) {
      if (date.year % 100 == 0) {
        return date.year % 400 == 0;
      }
      return true;
    }
    return false;
  }

  static List<int> differenceInYearsMonthsDays(DateTime dt1, DateTime dt2) {
    List<int> simpleYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    }
    int totalMonthsDifference = ((dt2.year * 12) + (dt2.month - 1)) -
        ((dt1.year * 12) + (dt1.month - 1));
    int years = (totalMonthsDifference / 12).floor();
    int months = totalMonthsDifference % 12;
    late int days;
    if (dt2.day >= dt1.day) {
      days = dt2.day - dt1.day;
    } else {
      int monthDays = dt2.month == 3
          ? (leapYear(dt2) ? 29 : 28)
          : (dt2.month - 2 == -1 ? simpleYear[11] : simpleYear[dt2.month - 2]);
      int day = dt1.day;
      if (day > monthDays) day = monthDays;
      days = monthDays - (day - dt2.day);
      months--;
    }
    if (months < 0) {
      months = 11;
      years--;
    }
    return [years, months, days];
  }
}

const String ROLE_DOCTOR = "DOCTOR";
const String ROLE_PATIENT = "PATIENT";
const String ROLE_INFLUENCER = "INFLUENCER";
