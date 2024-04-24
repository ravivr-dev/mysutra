class AppointmentEntity {
  String? id;
  String? doctorId;
  String? userId;
  String? profilePic;
  String? fullName;
  String? username;
  bool? isVerified;
  String? specialization;
  String? date;
  String? time;
  int? timeInMinutes;

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
  });
}
