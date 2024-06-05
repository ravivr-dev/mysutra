import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/logout_usecase.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final LocalDataSource localDataSource;
  final LogOutUsecase logoutUsecase;
  MainCubit({
    required this.localDataSource,
    required this.logoutUsecase,
  }) : super(AppStarted());

  checkSession() {
    final result = localDataSource.getAccessToken();
    if (result == null || result == "") {
      emit(LoggedOut());
    } else {
      emit(LoggedIn());
    }
  }

  logout() async {
    await logoutUsecase.call(NoParams());
    localDataSource.logout();
  }
}
