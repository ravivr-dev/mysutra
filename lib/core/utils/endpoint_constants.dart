// ignore_for_file: constant_identifier_names

class EndPoints {
  static const String login = '/user/login';
  static const String verifyOtp = '/user/verify-otp';
  static const String accounts = '/user/accounts';
  static const String userSpecialization = '/user/specialization';
  static const String userRegistration = '/user/registration';
  static const String uploadFile = '/upload/file';

// patient endpoints
  static const String patientSearch = '/patient/search';

  static const String doctorFollow = '/patient/doctor/follow';
  static const String availableSlots = '/patient/available-slots';
  static const String doctorDetails = '/patient/doctor';
  static const String scheduleAppointment = '/patient/appointment/schedule';
  static const String confirmAppointment = '/patient/appointment/confirm';

  // doctor endpoints
  static const String timeSlots = '/doctor/time-slots';
  static const String profile = '/doctor/profile';
}
