import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/coach_dashboard.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/cubit/dashboard_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/my_batches/cubit/my_batches_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/my_batches/my_batches_screen.dart';
import 'package:my_sutra/features/presentation/pages/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/home/widgets/custom_drawer.dart';
import 'package:my_sutra/features/presentation/pages/common/home/widgets/cutom_nav_bar.dart';
import 'package:my_sutra/features/presentation/pages/common/profile/cubit/profile_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/profile/profile_page.dart';
import 'package:my_sutra/features/presentation/pages/student/dashboard/dashboard_student.dart';
import 'package:my_sutra/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  final coachScreens = [
    BlocProvider<ProfileCubit>(
      create: (context) => sl<ProfileCubit>(),
      child: const ProfilePage(),
    ),
    BlocProvider<DashboardCubit>(
      create: (context) => sl<DashboardCubit>()
        ..getMyBatches()
        ..getCheckinStatus(),
      child: const DashboardCoach(),
    ),
    BlocProvider<MyBatchesCubit>(
      create: (context) => sl<MyBatchesCubit>(),
      child: const MyBatchesScreen(),
    ),
  ];

  final studentScreens = [
    BlocProvider<ProfileCubit>(
      create: (context) => sl<ProfileCubit>(),
      child: const ProfilePage(),
    ),
    BlocProvider<DashboardCubit>(
      create: (context) => sl<DashboardCubit>(),
      child: const DashboardStudent(),
    ),
    BlocProvider<MyBatchesCubit>(
      create: (context) => sl<MyBatchesCubit>(),
      child: const MyBatchesScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        title: appbarGetter(),
        showDrawer: true,
        centerTitle: true,
        showNotification: true,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onChnageScreen: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: context.read<HomeCubit>().userRole == "COACH"
            ? coachScreens
            : studentScreens,
      ),
    );
  }

  String appbarGetter() {
    if (currentIndex == 0) {
      return "My Profile";
    } else if (currentIndex == 1) {
      return "Dashboard";
    } else if (currentIndex == 2) {
      return "My Batches";
    } else {
      return "";
    }
  }
}
