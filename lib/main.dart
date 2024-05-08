import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/common/video_calling_screen/video_calling_screen.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import 'ailoitte_component_injector.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

final routeObserver = RouteObserver();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MainCubit>(),
      child: MaterialApp(
        title: 'My Sutra',
        localizationsDelegates: const [
          AiloitteMyLocalizationsDelegate(),
        ],
        navigatorObservers: [routeObserver],
        navigatorKey: navigationKey,
        onGenerateRoute: Routes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: const VideoCallingScreen(),
        // initialRoute: AppRoutes.splashRoutes,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: AppColors.color0xFF00082F.withOpacity(.27),
              ),
              scrolledUnderElevation: 0.0,
              centerTitle: true,
              titleTextStyle: theme.publicSansFonts.mediumStyle(fontSize: 20),
              backgroundColor: AppColors.backgroundColor),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
      ),
    );
  }
}
