part of 'package:my_sutra/features/presentation/common/home/home_screen.dart';

class _InfluencerHomeScreenState extends _HomeScreenState {
  @override
  void _reInitScreens() {
    _removeHomeScreen();
    _removePaymentsScreen();
    _addLearningManagement();
  }

  void _addLearningManagement() {
    //We don't have any LearningManagement Screen now so we are adding SizedBox for showing empty Screen
    _screens.insert(
        1,
        BlocProvider<ArticleCubit>(
          create: (context) => sl<ArticleCubit>(),
          child: const LMSUserFeed(),
        ));
    _bottomNavigationBarList.insert(
        1,
        _buildBottomBarItem(
            icon: Assets.iconsLearningManagement, label: 'LMS'));
  }

  void _removePaymentsScreen() {
    _screens.removeAt(2);
    _bottomNavigationBarList.removeAt(2);
  }

  void _removeHomeScreen() {
    _screens.removeAt(0);
    _bottomNavigationBarList.removeAt(0);
  }
}
