import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_history_usecase.dart';
import 'package:my_sutra/features/presentation/article/article_detail_screen.dart';
import 'package:my_sutra/features/presentation/article/create_or_edit_article_screen.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/lms_feed_screen.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_data_entity.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_screen.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/image_view_screen.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/home/home_screen.dart';
import 'package:my_sutra/features/presentation/common/home/screens/booking_cancelled_screen.dart';
import 'package:my_sutra/features/presentation/common/home/screens/reschedule_appointment_screen.dart';
import 'package:my_sutra/features/presentation/common/home/widgets/patient_my_following_screen.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/select_account_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/login_screen.dart';
import 'package:my_sutra/features/presentation/common/login/select_account.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/change_data_screen.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/my_profile_screen.dart';
import 'package:my_sutra/features/presentation/common/registration/choose_account_type_scree.dart';
import 'package:my_sutra/features/presentation/common/registration/create_account_screen.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/common/splash/doctor_waiting_screen.dart';
import 'package:my_sutra/features/presentation/common/splash/splash_screen.dart';
import 'package:my_sutra/features/presentation/common/video_calling/video_calling_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_follower/my_followers_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_following/doctor_my_following_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_patients/cubit/patient_appointment_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_patients/doctor_past_appointment_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_patients/my_patients_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/add_bank_account_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/add_upi_id_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/bank_account_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/earning_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/payment_checkout_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/payment_method_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/select_bank_account_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/withdraw_balance_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/settings_screen.dart';
import 'package:my_sutra/features/presentation/patient/cubit/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/patient/find_doctor_screen.dart';
import 'package:my_sutra/features/presentation/patient/payment_history/cubit/payment_history_cubit.dart';
import 'package:my_sutra/features/presentation/patient/payment_history/payment_history_screen.dart';
import 'package:my_sutra/features/presentation/patient/schedule_appointment_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search/doctor_result_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/search_result_screen.dart';
import 'package:my_sutra/features/presentation/patient/search_filter_screen.dart';
import 'package:my_sutra/features/presentation/patient/widgets/booking_successful_screen.dart';
import 'package:my_sutra/features/presentation/patient/widgets/patient_past_appointment_screen.dart';
import 'package:my_sutra/features/presentation/patient/widgets/rate_appointment_screen.dart';
import 'package:my_sutra/features/presentation/post_screens/create_post_screen.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/post_screen.dart';
import 'package:my_sutra/features/presentation/post_screens/repost_screen.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings? settings) {
    final Object? args;
    args = settings?.arguments;

    switch (settings?.name) {
      case AppRoutes.splashRoutes:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.waitingRoute:
        return MaterialPageRoute(
          builder: (_) => const DoctorsWaitingRoute(),
        );

      case AppRoutes.chooseAccountTypeRoute:
        return MaterialPageRoute(
          builder: (_) => const ChooseAccountTypeScreen(),
        );

      case AppRoutes.createAccountRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<RegistrationCubit>(),
            child: CreateAccountScreen(
              profession: args as String,
            ),
          ),
        );

      case AppRoutes.selectAccountRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SelectAccountCubit>()..getData(),
            child: const SelectAccountScreen(),
          ),
        );

      /// Patient Routes

      case AppRoutes.findDoctorRoute:
        return MaterialPageRoute(
          builder: (_) => const FindDoctorScreen(),
        );

      case AppRoutes.searchResultRoute:
        final args = settings?.arguments as SearchResultArgs?;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SearchDoctorCubit>(),
            child: SearchResultScreen(
              args: args,
            ),
          ),
        );
      case AppRoutes.settingRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SettingCubit>()..getTimeSlots(),
            child: const SettingsScreen(),
          ),
        );
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()),
                    BlocProvider<ChatCubit>(create: (_) => sl<ChatCubit>())
                  ],
                  child: HomeScreen(index: args as int?),
                ));
      case AppRoutes.scheduleAppointment:
        final args = settings?.arguments as ScheduleAppointmentScreenArgs;

        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => sl<AppointmentCubit>()),
                  BlocProvider(create: (_) => sl<RegistrationCubit>())
                ], child: ScheduleAppointmentScreen(args: args)));

      case AppRoutes.doctorDetail:
        final args = settings?.arguments as DoctorEntity;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SearchDoctorCubit>(
                  create: (context) => sl<SearchDoctorCubit>(),
                  child: DoctorResultScreen(doctorEntity: args),
                ));

      case AppRoutes.bookingSuccessful:
        return MaterialPageRoute(
            builder: (_) => const BookingSuccessfulScreen());

      case AppRoutes.bookingCancelled:
        return MaterialPageRoute(
            builder: (_) => const BookingCancelledScreen());

      case AppRoutes.patientPastAppointment:
        return MaterialPageRoute(
            //todo will implement pagination in this
            builder: (_) => BlocProvider<AppointmentCubit>(
                  create: (context) => sl<AppointmentCubit>()
                    ..getPastAppointments(pagination: 1, limit: 10),
                  child: const PatientPastAppointmentsScreen(),
                ));

      case AppRoutes.patientMyFollowing:
        final args = settings?.arguments as List<UserDataEntity>;

        return MaterialPageRoute(
            builder: (_) => PatientMyFollowingScreen(myFollowing: args));

      case AppRoutes.doctorMyFollowing:
        final args = settings?.arguments as List<UserDataEntity>;
        return MaterialPageRoute(
            builder: (_) => DoctorMyFollowingScreen(followers: args));

      case AppRoutes.doctorMyFollowers:
        return MaterialPageRoute(
          builder: (_) => MyFollowersScreen(
            followers: args as List<UserDataEntity>,
          ),
        );

      case AppRoutes.myPatients:
        return MaterialPageRoute(
            builder: (_) =>
                MyPatientsScreen(patients: args as List<PatientEntity>));

      case AppRoutes.doctorPastAppointment:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<PatientAppointmentCubit>(),
                  child:
                      DoctorPastAppointmentScreen(data: args as PatientEntity),
                ));

      case AppRoutes.chatScreen:
        final args = settings!.arguments as ChatScreenArgs;

        return MaterialPageRoute(
            settings: settings,
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<RegistrationCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<ChatCubit>(),
                    ),
                  ],
                  child: ChatScreen(args: args),
                ));

      case AppRoutes.searchFilterScreen:
        final data = settings?.arguments as SearchFilterArgs?;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => sl<RegistrationCubit>()..getSpecialisations(),
                  child: SearchFilterScreen(args: data),
                ));

      case AppRoutes.changeDataRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ProfileCubit>(
                  create: (context) => sl<ProfileCubit>(),
                  child: ChangeDataScreen(args: args as ChangeDataParams),
                ));

      case AppRoutes.rescheduleAppointment:
        final args = settings?.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<HomeCubit>(
                  create: (context) => sl<HomeCubit>(),
                  child: RescheduleAppointmentScreen(
                    appointmentId: args,
                  ),
                ));

      case AppRoutes.myProfileRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ProfileCubit>(
                  create: (context) => sl<ProfileCubit>(),
                  child: const MyProfileScreen(),
                ));
      case AppRoutes.videoCallingRoute:
        final args = settings?.arguments as VideoCallingArgs;
        return MaterialPageRoute(
            builder: (_) => VideoCallingScreen(args: args));

      case AppRoutes.postRoute:
        final args = settings?.arguments as String;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<PostsCubit>(
                      create: (context) => sl<PostsCubit>(),
                    ),
                    BlocProvider<SearchDoctorCubit>(
                      create: (context) => sl<SearchDoctorCubit>(),
                    ),
                  ],
                  child: PostScreen(
                    postId: args,
                  ),
                ));

      case AppRoutes.repostRoute:
        final args = settings?.arguments;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<PostsCubit>(
                      create: (context) => sl<PostsCubit>(),
                    ),
                    BlocProvider<SearchDoctorCubit>(
                      create: (context) => sl<SearchDoctorCubit>(),
                    ),
                  ],
                  child: RePostScreen(
                    postEntity: args as PostEntity,
                  ),
                ));

      case AppRoutes.editPostRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PostsCubit>(
                  create: (context) =>
                      sl<PostsCubit>()..getPostDetail(postId: args as String),
                  child: CreatePostScreen(
                    isEditing: true,
                    postId: args as String,
                  ),
                ));

      case AppRoutes.lmsFeedRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ArticleCubit>(
                  create: (context) => sl<ArticleCubit>(),
                  child: const LMSUserFeed(),
                ));

      case AppRoutes.createOrEditArticleRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ArticleCubit>(
                  create: (context) => sl<ArticleCubit>(),
                  child: CreateArticleScreen(
                      params: args as CreateOrEditScreenParams),
                ));

      case AppRoutes.articleDetailRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ArticleCubit>(
                  create: (context) => sl<ArticleCubit>(),
                  child: ArticleDetailScreen(articleId: args as String),
                ));

      case AppRoutes.imageViewRoute:
        return MaterialPageRoute(
          builder: (_) => ImageViewScreen(
            imageUrl: args as String,
          ),
        );

      case AppRoutes.paymentHistoryRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                sl<PaymentHistoryCubit>()..getData(PaginationParams()),
            child: const PaymentHistoryScreen(),
          ),
        );

      case AppRoutes.paymentCheckoutRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<EarningCubit>()..getProcessingAmount(),
            child: const PaymentCheckoutScreen(),
          ),
        );

      case AppRoutes.paymentMethodRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<BankAccountCubit>()..getData(),
            child: const PaymentMethodScreen(),
          ),
        );

      case AppRoutes.addBankAccountRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<BankAccountCubit>(),
            child: AddBankAccountScreen(showBasicDetails: args as bool),
          ),
        );

      case AppRoutes.addUpiIdRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<BankAccountCubit>(),
            child: AddUpiIdScreen(showBasicDetails: args as bool),
          ),
        );

      case AppRoutes.rateAppointmentRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AppointmentCubit>(
            create: (context) => sl<AppointmentCubit>(),
            child: RateAppointmentScreen(args: args as RateAppointmentArgs),
          ),
        );

      case AppRoutes.withdrawBalanceRoute:
        return MaterialPageRoute(
          builder: (_) => WithDrawBalanceScreen(amount: args as num),
        );

      case AppRoutes.selectBankAccountRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<EarningCubit>()..getAccounts(),
                  child: SelectBankAccountScreen(amount: args as int),
                ));

      // case AppRoutes.myBatchesRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => const MyBatchesScreen());

      // case AppRoutes.profileRoute:
      //   return MaterialPageRoute(builder: (_) => const ProfilePage());

      // case AppRoutes.changeDataRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider<ProfileCubit>(
      //             create: (context) => sl<ProfileCubit>(),
      //             child: ChangeDataPage(data: args as UpdateProfileParams),
      //           ));

      // case AppRoutes.markAttendanceRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //           create: (BuildContext context) => sl<AttendanceCubit>(),
      //           child: const MarkAttendanceScreen()));

      // case AppRoutes.notificationRoute:
      //   return MaterialPageRoute(builder: (_) => const NotificationScreen());

      // case AppRoutes.attendanceStatusRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => const AttendanceStatusScreen());

      // case AppRoutes.leaderboardRoute:
      //   return MaterialPageRoute(builder: (_) => const LeaderBoardScreen());

      // case AppRoutes.homeRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => sl<HomeCubit>()..initialDataLoader(),
      //             child: const HomeScreen(),
      //           ));

      // case AppRoutes.enrollmentsRoute:
      //   return MaterialPageRoute(builder: (_) => const EnrollmentsScreen());

      // case AppRoutes.addEnrollmentsRoute:
      //   return MaterialPageRoute(builder: (_) => const AddEnrollmentsScreen());

      // case AppRoutes.completeProfileScreen:
      //   return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings?.name}'),
            ),
          ),
        );
    }
  }
}
