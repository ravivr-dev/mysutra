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
  static const String rasorpayKey = '/payment/razorpay-key';
  static const String doctorFollow = '/patient/doctor/follow';
  static const String availableSlots = '/patient/available-slots';
  static const String doctorDetails = '/patient/doctor';
  static const String scheduleAppointment = '/patient/appointment/schedule';
  static const String confirmAppointment = '/patient/appointment/confirm';
  static const String appointments = '/patient/appointments';
  static const String cancelAppointment = '/patient/appointment/cancel';
  static const String pastAppointment = '/patient/appointments/past';
  static const String payment = '/payment';
  static const String paymentHistory = '/payment/patient/history';
  static const String appointmentRating = '/patient/appointments/rating';

  // doctor endpoints
  static const String timeSlots = '/doctor/time-slots';
  static const String profile = '/doctor/profile';
  static const String patients = '/doctor/patients';
  static const String home = '/doctor/home';
  static const String doctorAppointments = '/doctor/appointments';
  static const String doctorAppointmentReSchedule =
      '/doctor/appointment/re-schedule';
  static const String doctorAppointmentCancel = '/doctor/appointment/cancel';
  static const String doctorAvailableSlots = '/doctor/available-slots';
  static const String createContact = '/payment/payout/contact';
  static const String createFundAccount = '/payment/payout/fund-account/bank';
  static const String createUpi = '/payment/payout/fund-account/vpa';
  static const String fundAccounts = '/payment/payout/fund-account';
  static const String payout = '/payment/payout';

// user endpoints (these endpoints are common for all type of user (doctor/patient/influencer))
  static const String userProfile = '/user/profile';
  static const String generateUserName = '/user/generate-username';
  static const String userMessage = '/user/message';
  static const String clearMessage = '/user/message/clear';
  static const String userHome = '/user/home';
  static const String changeEmail = '/user/change-email';
  static const String verifyChangeEmail = '/user/change-email/verify-otp';
  static const String changePhoneNumber = '/user/change-phone-number';
  static const String verifyChangePhoneNumber =
      '/user/change-phone-number/verify-otp';
  static const String userFollowing = '/user/followings';
  static const String userFollowers = '/user/followers';
  static const String videoSdkRoom = '/user/videosdk/room';
  static const String userFollow = '/user/follow';
  static const String deviceToken = '/user/device-token';

  // Posts Endpoints
  static const String searchUserName = '/post/search';
  static const String post = '/post';
  static const String postReport = '/post/report';
  static const String postLikeDislike = '/post/like-dislike';
  static const String comment = '/comment';
  static const String commentLikeDislike = '/comment/like-dislike';
  static const String reply = '/reply';
  static const String replyLikeDislike = '/reply/like-dislike';

  //Article Endpoints
  static const String article = '/article';
  static const String likeDislikeArticle = '/article/like';
  static const String reportArticle = '/article/report';
  static const String articleComment = '/article/comment';
  static const String likeDislikeArticleComment =
      '/article/comment/like-dislike';
  static const String articleReply = '/article/reply';
  static const String likeDislikeArticleReply = '/article/like-dislike';
}
