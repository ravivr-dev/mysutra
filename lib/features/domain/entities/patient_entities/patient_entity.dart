class PatientEntity {
  final String id;
  final String? userName;
  final String? profilePic;
  final String? countryCode;
  final int? phoneNumber;
  final String? date;
  final String? time;
  final int? timeInMinutes;

  PatientEntity({
    required this.date,
    required this.time,
    required this.id,
    required this.userName,
    required this.countryCode,
    required this.phoneNumber,
    required this.profilePic,
    required this.timeInMinutes,
  });
}
