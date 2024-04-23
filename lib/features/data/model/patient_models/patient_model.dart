import 'package:my_sutra/core/utils/constants.dart';

class PatientModel {
  final String id;
  final String? userName;
  final String? profilePic;
  final String? countryCode;
  final int? phoneNumber;
  final String? date;
  final String? time;
  final int? timeInMinutes;

  PatientModel({
    required this.date,
    required this.time,
    required this.id,
    required this.userName,
    required this.countryCode,
    required this.phoneNumber,
    required this.profilePic,
    required this.timeInMinutes,
  });

  PatientModel.fromJson(Map<String, dynamic> json)
      : id = json[Constants.id],
        userName = json[Constants.userName],
        profilePic = json[Constants.profilePic],
        countryCode = json[Constants.countryCode],
        phoneNumber = json[Constants.phoneNumber],
        date = json[Constants.date],
        time = json[Constants.time],
        timeInMinutes = json[Constants.timeInMinutes];
}
