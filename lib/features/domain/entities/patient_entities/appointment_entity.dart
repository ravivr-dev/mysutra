/// We are not getting fullName of (patient from doctor side) in this please show username if you want to show patient name anywhere
class AppointmentEntity {
  String id;
  String? doctorId;
  String? userId;
  String? username;
  String date;
  String time;
  int? timeInMinutes;

  /// we will get these values when we will get Patient Details
  final String? countryCode;
  final int? phoneNumber;
  final String? reason;

  /// we will get these values when we will get Doctor Details
  String? profilePic;
  String? fullName;
  bool? isVerified;
  String? specialization;

  AppointmentEntity({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.profilePic,
    required this.fullName,
    required this.username,
    required this.isVerified,
    required this.specialization,
    required this.date,
    required this.time,
    required this.timeInMinutes,
    this.phoneNumber,
    this.countryCode,
    this.reason,
  });
}
