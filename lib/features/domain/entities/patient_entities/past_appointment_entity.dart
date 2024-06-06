class PastAppointmentResponseEntity {
  final String id;
  final String doctorId;
  final String userId;
  final String profilePic;
  final String fullName;
  final String username;
  final bool isVerified;
  final String specialization;
  final String date;
  final String time;
  final int timeInMinutes;
  final int fees;
  final int tax;
  final int totalAmount;
  final List<String> prescriptions;
  final String videoSdkRoomId;
  final String videoSdkToken;

  PastAppointmentResponseEntity(
      {required this.id,
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
      required this.fees,
      required this.tax,
      required this.totalAmount,
      required this.prescriptions,
      required this.videoSdkRoomId,
      required this.videoSdkToken});
}
