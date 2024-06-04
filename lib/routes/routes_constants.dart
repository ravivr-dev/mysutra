class AppRoutes {
  static const String splashRoutes = "/splash_screen";
  static const String loginRoute = "/login_screen";
  static const String chooseAccountTypeRoute = "/choose_account_type_screen";
  static const String createAccountRoute = "/create_account_screen";
  static const String selectAccountRoute = "/select_account_screen";
  static const String myProfileRoute =
      "/common/profile_screen/my_profile_screen";

  // patient routes
  static const String findDoctorRoute = "/find_doctor_screen";
  static const String searchDoctorRoute = "/search_doctor_screen";
  static const String searchResultRoute = "/search_result_screen";
  static const String settingRoute = '/doctor_screens/settings_screen';
  static const String scheduleAppointment =
      '/patient/schedule_appointment_screen';
  static const String doctorDetail = '/patient/search/doctor_result_screen';
  static const String bookingSuccessful =
      '/patient/widgets/booking_successful_screen';

  static const String bookingCancelled =
      '/common/home/screens/booking_cancelled_screen';
  static const String patientPastAppointment =
      '/patient/widgets/patient_past_appointment_screen';
  static const String patientMyFollowing =
      '/common/home/widgets/patient_my_following_screen';
  static const String doctorMyFollowing =
      '/doctor_screens/my_following/doctor_my_following_screen';
  static const String doctorMyFollowers =
      '/doctor_screens/my_follower/my_followers_screen';
  static const String myPatients =
      '/doctor_screens/my_patients/my_patients_screen';
  static const String doctorPastAppointment =
      '/doctor_screens/my_patients/doctor_past_appointment_screen';
  static const String chatScreen = '/patient/chat_screen';

  static const String searchFilterScreen = '/patient/search_filter_screen';

  static const String changeDataRoute =
      '/common/profile_screen/change_data_screen';
  static const String rescheduleAppointment =
      '/common/home/screens/reschedule_appointment_screen';
  static const String videoCallingRoute = 'video_calling/video_calling_screen';

  static const String postRoute = '/post_screens/post_screen';
  static const String repostRoute = '/post_screens/repost_screen';
  static const String editPostRoute = '/post_screens/create_post';

  static const String lmsFeedRoute = '/article/lms_feed_screen';
  static const String createOrEditArticleRoute = '/article/create_article';
  static const String articleDetailRoute = '/article/article_detail_screen';

  static const String imageViewScreen = '/image_view_screen';

  static const String imageViewRoute = '/image_view_screen';
  static const String paymentHistoryRoute = '/payment_history_screen';
  static const String paymentCheckoutRoute = '/payment_checkout_screen';
  static const String paymentMethodRoute = '/payment_method_screen';
  static const String addBankAccountRoute = '/add_bank_account_screen';
  static const String addUpiIdRoute = '/add_upi_id_screen';

  static const String rateAppointmentRoute =
      '/patient/widget/rate_appointment_screen';

  /// old routes
  // static const String myBatchesRoute = "/my_batches_screen";
  // static const String markAttendanceRoute = "/mark_attendance_screen";
  // static const String profileRoute = "/profile_page";
  // static const String changeDataRoute = "/change_data_page";
  // static const String notificationRoute = "/notification_screen";
  // static const String attendanceStatusRoute = "/attendance_status_page";
  // static const String leaderboardRoute = "/leaderboard_screen";
  static const String homeRoute = "/home_screen";
// static const String enrollmentsRoute = "/enrollments_screen";
// static const String addEnrollmentsRoute = "/add_enrollments_screen";

// static const String completeProfileScreen = "/complete_profile_screen";
}
