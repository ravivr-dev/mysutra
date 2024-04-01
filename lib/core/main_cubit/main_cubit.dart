import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final LocalDataSource localDataSource;
  MainCubit(this.localDataSource) : super(AppStarted());

  checkSession() {
    final result = localDataSource.getAccessToken();
    if (result == null || result == "") {
      emit(LoggedOut());
    } else {
      emit(LoggedIn());
    }
  }

  logout() {
    localDataSource.logout();
  }
}
