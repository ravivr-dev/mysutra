import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit(
    this.loginUsecase,
  ) : super(LoginInitial());

  login(LoginParams params) async {
    emit(LoginLoading());
    final result = await loginUsecase(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(
        LoginSuccess(data),
      );
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(LoginError(failure.message));
    } else if (failure is CacheFailure) {
      emit(LoginError(failure.message));
    } else {
      emit(LoginError(failure.message));
    }
  }
}
