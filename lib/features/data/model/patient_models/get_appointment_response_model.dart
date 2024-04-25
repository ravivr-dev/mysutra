import 'package:my_sutra/core/utils/constants.dart';

class GetAppointmentResponseModel {
  final String message;
  final int count;
  final List<AppointmentModel> data;

  GetAppointmentResponseModel({
    required this.message,
    required this.count,
    required this.data,
  });

  GetAppointmentResponseModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        count = json[Constants.count],
        data = (json[Constants.data] as List)
            .map((e) => AppointmentModel.fromJson(e))
            .toList();
}

class AppointmentModel {
  String? id;
  String? doctorId;
  String? userId;
  String? profilePic;
  String? fullName;
  String? username;
  bool? isVerified;
  String? specialization;
  String date;
  String time;
  int? timeInMinutes;
  String? countryCode;
  int? phoneNumber;
  String? reason;

  AppointmentModel({
    this.id,
    this.doctorId,
    this.userId,
    this.profilePic,
    this.fullName,
    this.username,
    this.isVerified,
    this.specialization,
    required this.date,
    required this.time,
    this.timeInMinutes,
    this.reason,
    required this.countryCode,
    required this.phoneNumber,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json)
      : id = json[Constants.id],
        doctorId = json[Constants.doctorId],
        userId = json[Constants.userId],
        profilePic = json[Constants.profilePic],
        fullName = json[Constants.fullName],
        username = json[Constants.userName],
        isVerified = json[Constants.isVerified],
        specialization = json[Constants.specialization],
        date = json[Constants.date],
        time = json[Constants.time],
        timeInMinutes = json[Constants.timeInMinutes],
        phoneNumber = json[Constants.phoneNumber],
        countryCode = json[Constants.countryCode],
        reason = json[Constants.reason];
}
