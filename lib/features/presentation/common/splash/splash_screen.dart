import 'dart:async';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context.read<MainCubit>().checkSession();
    // });
    _handleNavigation();
  }

  void _handleNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      AiloitteNavigation.intentWithClearAllRoutes(
          context, AppRoutes.loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // if (state is LoggedIn) {
        //   AiloitteNavigation.intentWithClearAllRoutes(
        //       context, AppRoutes.homeRoute);
        // } else if (state is LoggedOut) {
        //   _handleNavigation();
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: Lottie.asset(Assets.imagesSplash,
                fit: BoxFit.contain, repeat: false),
          ),
        );
      },
    );
  }
}
