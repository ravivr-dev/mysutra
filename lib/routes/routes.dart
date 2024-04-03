import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/presentation/pages/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/login/login_screen.dart';
import 'package:my_sutra/features/presentation/pages/common/login/select_account.dart';
import 'package:my_sutra/features/presentation/pages/common/registration/choose_account_type_scree.dart';
import 'package:my_sutra/features/presentation/pages/common/registration/create_account_screen.dart';
import 'package:my_sutra/features/presentation/pages/common/splash/splash_screen.dart';
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
          builder: (_) => CreateAccountScreen(
            profession: args as String,
          ),
        );

      case AppRoutes.selectAccountRoute:
        return MaterialPageRoute(
          builder: (_) => const SelectAccountScreen(),
        );

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
