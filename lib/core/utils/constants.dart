// ignore_for_file: constant_identifier_names

// import 'package:flutter/services.dart';

class Constants {
  static const String appName = "Sportync";

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
  static const String aboutAddedSuccessFully = "About Added Successfully";
  static const String youHaveUsedAllAvailableAttempt =
      "All available attempts for this quiz already used";
  static const String quizAlreadySubmitted = "Quiz already submitted";

  // static const String platformAndroid = "android";
  // static const String platformIos = "ios";
  // static const String redirectTo = "redirectTo";
  // static const String redirectDataId = "redirectDataId";

  static const String baseUrl = "https://api-dev.sportync.com/";

  /// Socket Url
  // static const String socialSocketUrl =
  //     "wss://jiss5vrid8.execute-api.eu-west-2.amazonaws.com/websocket";
  // static const String stripePaymentIntentUrl =
  //     'https://api.stripe.com/v1/payment_intents';

  // static const String socketIoUnhandledException = "unhandled_exception";
  // static const String socketError = "errors";
  // static const String socketErrorParams = "error_params";

  // static const String apiVersion = "/api/v1";

  // static bool initialUriHandled = false;

  // static const String resourceRequestStatusApproved = "approved";
  // static const String resourceRequestStatusDeclined = "declined";

  // static const String countryCodeUK = "+44";

  // static const String verificationStatusApproved = "approved";
  // static const String verificationStatusPending = "pending";

  // static const String typeResearch = "research";
  // static const String typePresentation = "presentation";

  // static const String imageFileType = "image";
  // static const String videoFileType = "video";
  // static const String documentFileType = "document";
  // static const String contentTypeForPayment =
  //     'application/x-www-form-urlencoded';

  ///Type of format
  // static const String dateFormatYYYY_MM_DD = "yyyy/MM/dd";

  // static const String defaultCountryCode = "+91";
  // static const String mobileNumberType = "mobileNumber";
  // static const String emailType = "email";

  // static String activeStatus = "active";
  // static const String pendingStatus = "pending";
  // static const String approvedStatus = "approved";
  // static const String newStatus = "new";
  // static const String completedStatus = "completed";
  // static const String cancelStatus = "cancelled";
  // static const String opneStatus = "open";
  // static const String closedStatus = "closed";
  // static const String resolvedStatus = "resolved";
  // static const String deletedStatus = "deleted";

// // User
//   static const String userTypeWorker = "CLIENT";
//   static const String userTypeEmployer = "VENDOR";
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
