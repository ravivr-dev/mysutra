import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/presentation/common/home/home_screen.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/select_account_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/login_screen.dart';
import 'package:my_sutra/features/presentation/common/login/select_account.dart';
import 'package:my_sutra/features/presentation/common/registration/choose_account_type_scree.dart';
import 'package:my_sutra/features/presentation/common/registration/create_account_screen.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/common/splash/splash_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/settings_screen.dart';
import 'package:my_sutra/features/presentation/patient/find_doctor_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search/search_result_screen.dart';
import 'package:my_sutra/features/presentation/patient/search_doctor_screen.dart';
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

      case AppRoutes.searchDoctorRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchDoctorScreen(),
        );

      case AppRoutes.searchResultRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SearchDoctorCubit>(),
            child: const SearchResultScreen(),
          ),
        );
      case AppRoutes.settingRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SettingCubit>(),
            child: const SettingsScreen(),
          ),
        );
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

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
