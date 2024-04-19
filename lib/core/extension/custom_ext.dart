import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';

import '../utils/endpoint_constants.dart';

extension CustomDateTimeFunction on DateTime {
  String getFormattedDateTimeInStringYYYYMMDD(
      {final String formatter = Constants.serverDateFormat}) {
    final DateFormat dateFormat = DateFormat(formatter);

    return dateFormat.format(this);
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}

extension RequestOptionsFunction on RequestOptions {
  RequestOptions addRequestOptions(
    final LocalDataSource localDataSource, {
    String? token,
  }) {
    final accessToken = token ?? localDataSource.getAccessToken() ?? '';
    log(accessToken, name: "Bearer");
    if (accessToken.isNotEmpty && path != EndPoints.confirmAppointment) {
      headers[Constants.authorization] = "Bearer $accessToken";
    }
    return this;
  }
}
