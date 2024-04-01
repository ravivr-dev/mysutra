import 'dart:math';


import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/core/config/localization.dart';
import 'package:my_sutra/core/utils/configuration.dart';
import 'package:my_sutra/core/utils/constants.dart';

extension StringFunctions on String {
  String stringForLangKey({
    required final BuildContext context,
  }) {
    return MyLocalizations.of(context).getString(this);
  }

  String userProfileId() {
    return "@ $this";
  }

  String get addColon => "$this: ";

  Future<void> copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: this)).then((value) async {
      // await Fluttertoast.cancel();

      Fluttertoast.showToast(
        msg: 'Copied',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    });
  }

  String removeSpecialChar() {
    return replaceAll(RegExp('[^A-Za-z0-9]'), ' ').trim();
  }

  String get fileNameTimeStamp {
    return DateTime.now().toString().formatDate(dateFormat: "yyyyMMdd_hhmmss");
  }

  String fileName(String type) {
    return "$type/_$fileNameTimeStamp.$type";
  }

  String getRandomString(int length) {
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => codeUnitAt(rnd.nextInt(this.length)),
      ),
    );
  }

  String formatDate({String? dateFormat}) {
    return DateFormat(dateFormat ?? Constants.serverDateFormat)
        .format(DateTime.parse(this));
  }

  DateTime dateTime({String? dateFormat}) {
    return DateTime.parse(this);
  }

  Duration duration({required DateTime endDate}) {
    return DateTime.parse(this).difference(endDate);
  }

  String? validateName() {
    return isEmpty
        ? "enterName"
        : length < 4
            ? null
            : "enterValidName";
  }

  String? validateEmail() {
    return isEmpty
        ? "Enter Email"
        : isValidEmail
            ? null
            : "Enter Valid Email";
  }

  String? validateMobile() {
    return isEmpty
        ? "Enter Mobile Number"
        : (RegExp('[6-9]\\d{${AppConfiguration.mobileNumberMaxLength - 1},${AppConfiguration.mobileNumberMaxLength}}')
                .hasMatch(this)
            ? null
            : "Enter Valid Mobile Number");
  }

  String? validatePasswordStr() {
    if (isEmpty) {
      return "Please Enter the Password";
    } else if (length < AppConfiguration.passwordLength) {
      return "Please Enter password with minimum ${AppConfiguration.passwordLength} words";
    }
    return null;
  }

  // String? getCommentTimeAgoFormat() {
  //   final DateTime date = DateTime.parse(this);
  //
  //   return timeago.format(date, locale: 'en_short').replaceAll('~', '');
  // }

  // String? timeAgoFormat() {
  //   final date = DateTime.parse(this).toLocal();
  //   final now = DateTime.now();
  //   final difference = now.difference(date);
  //
  //   return timeago.format(now.subtract(difference),
  //       allowFromNow: true, locale: "en");
  // }

  // String? chatTimeAgoFormat() {
  //   final date = DateTime.parse(this).toLocal();
  //   if (date.isToday()) {
  //     return date.getFormattedDateTimeInStringYYYYMMDD(formatter: "hh:mm a");
  //   } else if (date.isYesterday()) {
  //     return "Yesterday";
  //   } else {
  //     return date.getFormattedDateTimeInStringYYYYMMDD(formatter: "dd/MM/yyyy");
  //   }
  // }

  // bool get checkIfFileTypeIsImage {
  //   return this == Constants.imageFileType ||
  //       endsWith("jpg") ||
  //       endsWith("jpeg") ||
  //       endsWith("png");
  // }

  // bool get checkIfFileTypeIsVideo {
  //   return this == Constants.videoFileType || endsWith("mp4");
  // }

  // bool get checkIfFileTypeIsDocumentPdf {
  //   return this == Constants.documentFileType || endsWith("pdf");
  // }

  DateTime? getStringLiteralToDateTimeObject() {
    return DateTime.tryParse(this);
  }

  String capitalize() {
    return length < 2
        ? toUpperCase()
        : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  // bool validUrl() {
  //   return isURL(this) && (isValidUrl == null);
  // }
}

class RandomStringGenerator {
  String getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }
}
