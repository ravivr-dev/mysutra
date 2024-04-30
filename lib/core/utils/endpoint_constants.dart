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
  static const String appointments = '/patient/appointments';
  static const String cancelAppointment = 'patient/appointment/cancel';

  // doctor endpoints
  static const String timeSlots = '/doctor/time-slots';
  static const String profile = '/doctor/profile';
  static const String patients = '/doctor/patients';
  static const String home = '/doctor/home';
  static const String doctorAppointments = '/doctor/appointments';

// user endpoints (these endpoints are common for all type of user (doctor/patient/influencer))
  static const String userProfile = '/user/profile';
  static const String generateUserName = '/user/generate-username';
  static const String userHome = '/user/home';
  static const String changeEmail = '/user/change-email';
  static const String verifyChangeEmail = '/user/change-email/verify-otp';
  static const String changePhoneNumber = '/user/change-phone-number';
  static const String verifyChangePhoneNumber =
      '/user/change-phone-number/verify-otp';
  static const String userFollowing = '/user/followings';
}
