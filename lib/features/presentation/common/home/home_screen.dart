
import 'package:flutter/material.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/features/presentation/common/home/widgets/custom_drawer.dart';
import 'package:my_sutra/features/presentation/common/home/widgets/cutom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  // final coachScreens = [
  //   BlocProvider<ProfileCubit>(
  //     create: (context) => sl<ProfileCubit>(),
  //     child: const ProfilePage(),
  //   ),
  //   BlocProvider<DashboardCubit>(
  //     create: (context) => sl<DashboardCubit>()
  //       ..getMyBatches()
  //       ..getCheckinStatus(),
  //     child: const DashboardCoach(),
  //   ),
  //   BlocProvider<MyBatchesCubit>(
  //     create: (context) => sl<MyBatchesCubit>(),
  //     child: const MyBatchesScreen(),
  //   ),
  // ];

  // final studentScreens = [
  //   BlocProvider<ProfileCubit>(
  //     create: (context) => sl<ProfileCubit>(),
  //     child: const ProfilePage(),
  //   ),
  //   BlocProvider<DashboardCubit>(
  //     create: (context) => sl<DashboardCubit>(),
  //     child: const DashboardStudent(),
  //   ),
  //   BlocProvider<MyBatchesCubit>(
  //     create: (context) => sl<MyBatchesCubit>(),
  //     child: const MyBatchesScreen(),
  //   ),
  // ];

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
        children: [Container()],
        // children: context.read<HomeCubit>().userRole == "COACH"
        //     ? coachScreens
        //     : studentScreens,
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
