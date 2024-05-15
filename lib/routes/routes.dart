import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_data_entity.dart';
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
import 'package:my_sutra/features/presentation/common/splash/splash_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_following/doctor_my_following_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_patients/doctor_past_appointment_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_patients/my_patients_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/settings_screen.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_screen.dart';
import 'package:my_sutra/features/presentation/patient/find_doctor_screen.dart';
import 'package:my_sutra/features/presentation/patient/schedule_appointment_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search/doctor_result_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/search_result_screen.dart';
import 'package:my_sutra/features/presentation/patient/search_filter_screen.dart';
import 'package:my_sutra/features/presentation/patient/widgets/booking_successful_screen.dart';
import 'package:my_sutra/features/presentation/patient/widgets/patient_past_appointment_screen.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/post_screen.dart';
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

      // case AppRoutes.searchDoctorRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => const AppointmentScreen(),
      //   );

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
        return MaterialPageRoute(builder: (_) => const HomeScreen());
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
            builder: (_) => const PatientPastAppointmentsScreen());

      case AppRoutes.patientMyFollowing:
        final args = settings?.arguments as List<UserDataEntity>;

        return MaterialPageRoute(
            builder: (_) => PatientMyFollowingScreen(myFollowing: args));

      case AppRoutes.doctorMyFollowing:
        final args = settings?.arguments as List<UserDataEntity>;
        return MaterialPageRoute(
            builder: (_) => DoctorMyFollowingScreen(followers: args));

      case AppRoutes.myPatients:
        final args = settings?.arguments as List<PatientEntity>;
        return MaterialPageRoute(
            builder: (_) => MyPatientsScreen(patients: args));

      case AppRoutes.doctorPastAppointment:
        return MaterialPageRoute(
            builder: (_) => const DoctorPastAppointmentScreen());
      case AppRoutes.chatScreen:
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
                  child: const ChatScreen(),
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
