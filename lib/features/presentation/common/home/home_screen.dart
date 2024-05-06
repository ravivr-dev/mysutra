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

import '../../../../core/models/user_helper.dart';
import '../../../../injection_container.dart';

part 'home_screen_states/doctor_home_screen_state.dart';

part 'home_screen_states/influencer_home_screen_state.dart';

part 'home_screen_states/patient_home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState.init();
}

abstract class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreen = 0;

  final List<Widget> _screens = [
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
  late final List<BottomNavigationBarItem> _bottomNavigationBarList =
      _getNavigationBarList();

  _HomeScreenState();

  factory _HomeScreenState.init() {
    if (UserHelper.role == UserRole.doctor) {
      return _DoctorHomeScreenState();
    } else if (UserHelper.role == UserRole.influencer) {
      return _InfluencerHomeScreenState();
    }
    return _PatientHomeScreenState();
  }

  @override
  void initState() {
    _reInitScreens();
    super.initState();
  }

  /// this method is for change screens and bottomNavigationBar (like in case of influencer we want to show 3 screen in navbar so we can reinit the value of _screens)
  void _reInitScreens();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _screens[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle:
            theme.publicSansFonts.regularStyle(fontColor: AppColors.grey92),
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
        unselectedItemColor: AppColors.grey92,
        showUnselectedLabels: true,
        items: _bottomNavigationBarList,
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavigationBarList() {
    return [
      _buildBottomBarItem(icon: Assets.assetsIconsHome2, label: 'Home'),
      _buildBottomBarItem(icon: Assets.iconsFeed, label: 'Feed'),
      const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 10),
            child: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.add, color: AppColors.white)),
          ),
          label: ''),
      _buildBottomBarItem(icon: Assets.iconsPayment, label: 'Payments'),
      _buildBottomBarItem(icon: Assets.iconsUser2, label: 'My Profile'),
    ];
  }

  BottomNavigationBarItem _buildBottomBarItem(
      {required String icon, required String label}) {
    return BottomNavigationBarItem(
        icon: component.assetImage(path: icon),
        activeIcon:
            component.assetImage(path: icon, color: AppColors.primaryColor),
        label: label);
  }
}
