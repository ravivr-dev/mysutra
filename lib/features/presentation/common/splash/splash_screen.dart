import 'dart:async';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import '../../../../injection_container.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import '../../doctor_screens/bottom_sheets/verification_pending_bottom_sheet.dart';
import '../home/cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final localDataSource = sl<LocalDataSource>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MainCubit>().checkSession();
    });
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
      listener: (context, state) async {
        if (state is LoggedIn) {
          final totalAccount = localDataSource.getTotalUserAccounts;
          final isAccountSelected = localDataSource.getIsAccountSelected;
          if (totalAccount == null) {
            _handleNavigation();
            return;
          } else if (totalAccount > 1 && isAccountSelected != true) {
            AiloitteNavigation.intentWithClearAllRoutes(
                context, AppRoutes.selectAccountRoute);
            return;
          }

          //todo need to refactor this don't use localdatasource directly here
          final role = localDataSource.getUserRole();
          if (role.isNotEmpty) {
            UserHelper.init(role: role);
            if (UserRole.getUserRole(role) == UserRole.doctor &&
                !localDataSource.getIsDoctorVerified) {
              await context.showBottomSheet(
                BlocProvider(
                  create: (_) => sl<HomeCubit>(),
                  child: const VerificationPendingBottomSheet(),
                ),
              );
              AiloitteNavigation.intentWithClearAllRoutes(
                  context, AppRoutes.waitingRoute);
              return;
            }
            AiloitteNavigation.intentWithClearAllRoutes(
                context, AppRoutes.homeRoute);
            return;
          }
          _handleNavigation();
        } else if (state is LoggedOut) {
          _handleNavigation();
        }
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
