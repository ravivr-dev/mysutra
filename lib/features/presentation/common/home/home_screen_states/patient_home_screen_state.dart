part of 'package:my_sutra/features/presentation/common/home/home_screen.dart';

class _PatientHomeScreenState extends _HomeScreenState {
  @override
  void _reInitScreens() {
    _screens.insert(0, _screens.removeAt(1));
    _bottomNavigationBarList.insert(0, _bottomNavigationBarList.removeAt(1));
  }
}
