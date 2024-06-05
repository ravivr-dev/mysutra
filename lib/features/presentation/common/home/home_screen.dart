import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/push_notification_services.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/set_user_data_usecase.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/lms_feed_screen.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/home/screens/appointment_screen.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/my_profile_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/create_post_screen.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/user_feed_screen.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../../../core/models/user_helper.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/user_entities/user_entity.dart';

part 'home_screen_states/doctor_home_screen_state.dart';
part 'home_screen_states/influencer_home_screen_state.dart';
part 'home_screen_states/patient_home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  final int? index;

  const HomeScreen({super.key, this.index = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState.init();
}

abstract class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver {
  late int _selectedScreen;
  late PushNotificationService notificationServices;
  UserEntity? _userEntity;
  static bool _isUserOnline = false;

  late final List<Widget> _screens = [
    AppointmentScreen(entity: _userEntity),
    MultiBlocProvider(providers: [
      BlocProvider<PostsCubit>(
        create: (context) => sl<PostsCubit>(),
      ),
      BlocProvider<SearchDoctorCubit>(
        create: (context) => sl<SearchDoctorCubit>(),
      ),
    ], child: const UserFeedScreen()),
    BlocProvider<PostsCubit>(
      create: (context) => sl<PostsCubit>(),
      child: const CreatePostScreen(),
    ),
    BlocProvider<ArticleCubit>(
        create: (context) => sl<ArticleCubit>(), child: const LMSUserFeed()),
    BlocProvider<ProfileCubit>(
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
    _selectedScreen = widget.index ?? 0;
    _reInitScreens();
    WidgetsBinding.instance.addObserver(this);
    notificationServices = PushNotificationService();
    notificationServices.intiLocalNotifications();
    notificationServices.forgroundMessage();
    updateDeviceToken();

    super.initState();
  }

  @override
  void dispose() {
    _setUserData(isOnline: false);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _setUserData(isOnline: false);
    } else if (state == AppLifecycleState.resumed) {
      _setUserData();
    }
    super.didChangeAppLifecycleState(state);
  }

  /// this method is for change screens and bottomNavigationBar (like in case of influencer we want to show 3 screen in navbar so we can reinit the value of _screens)
  void _reInitScreens();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<HomeCubit, HomeState>(builder: (_, state) {
        if (state is GetHomeDataSuccessState) {
          _userEntity = state.entity;
          _setUserData();
        }
        final screen = _screens[_selectedScreen];
        if (screen is AppointmentScreen && screen.entity == null) {
          _screens[_selectedScreen] = AppointmentScreen(entity: _userEntity);
        }
        return screen;
      }),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle:
            theme.publicSansFonts.regularStyle(fontColor: AppColors.grey92),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreen,
        onTap: (index) {
          // if (index == 2) {
          //   return;
          // }
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

  ///We are using this _isUserOnline because we don't want to increase firebase read
  void _setUserData({bool isOnline = true}) {
    if ((_userEntity?.id ?? '').isNotEmpty) {
      if (!_isUserOnline && isOnline) {
        _setUserOnlineOfflineStatus(isOnline: true);
        _isUserOnline = true;
      } else if (_isUserOnline && !isOnline) {
        _setUserOnlineOfflineStatus(isOnline: false);
        _isUserOnline = false;
      }
    }
  }

  void _setUserOnlineOfflineStatus({required isOnline}) {
    if (mounted) {
      context.read<ChatCubit>().setUserData(SetUserDataParams(
            userId: _userEntity!.id,
            lastOnlineAt: Timestamp.now(),
            isOnline: isOnline,
          ));
    }
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
      _buildBottomBarItem(icon: Assets.iconsLms, label: 'LMS'),
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

  updateDeviceToken() async {
    String deviceToken = await notificationServices.getToken();
    if (mounted) {
      context.read<HomeCubit>().updateDeviceToken(deviceToken);
    }
  }
}
