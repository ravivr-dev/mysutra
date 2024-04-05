import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_otp_usecase.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final LoginUsecase loginUsecase;
  final OtpUsecase verifyOtpUsecase;


  OtpCubit(this.loginUsecase,this.verifyOtpUsecase) : super(OtpInitial());

  resendOtp(LoginParams params) async {
    final result = await loginUsecase(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(
        ResendOtpSuccess(data),
      );
    });
  }

  verifyOtp(int otp) async {
    emit(OtpLoading());
    final result = await verifyOtpUsecase(otp);

    result.fold((l) => _emitFailure(l), (data) {
      emit(
        OtpSuccess(data),
      );
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(OtpError(failure.message));
    } else if (failure is CacheFailure) {
      emit(OtpError(failure.message));
    } else {
      emit(OtpError(failure.message));
    }
  }
}
