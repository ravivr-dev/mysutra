import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/my_profile_screen.dart';
import 'package:my_sutra/features/presentation/common/home/screens/appointment_screen.dart';
import 'package:my_sutra/features/presentation/post_screens/post_screen.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../../../injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreen = 0;

  late final List<Widget> _screens = [
    BlocProvider<HomeCubit>(
      create: (BuildContext context) => sl<HomeCubit>()..getHomeData(),
      child: const AppointmentScreen(),
    ),
    const PostScreen(),
    const SizedBox.shrink(),
    Container(),
    BlocProvider(
      create: (BuildContext context) => sl<ProfileCubit>(),
      child: const MyProfileScreen(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _screens[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreen,
        onTap: (index) {
          if (index == 2) {
            return;
          }
          setState(() {
            _selectedScreen = index;
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.black33,
        showUnselectedLabels: true,
        items: [
          _buildBottomBarItem(icon: Assets.iconsHome2, label: 'Home', index: 0),
          _buildBottomBarItem(icon: Assets.iconsFeed, label: 'Feed', index: 1),
          const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10),
                child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.add, color: AppColors.white)),
              ),
              label: ''),
          _buildBottomBarItem(
              icon: Assets.iconsPayment, label: 'Payments', index: 3),
          _buildBottomBarItem(
              icon: Assets.iconsUser2, label: 'My Profile', index: 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomBarItem(
      {required String icon, required String label, required int index}) {
    final isSelected = index == _selectedScreen;
    return BottomNavigationBarItem(
        icon: component.assetImage(
            path: icon,
            color: isSelected ? AppColors.primaryColor : AppColors.black39),
        label: label);
  }
}
