import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_otp_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_otp_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/user_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserProfileUsecase userProfileUsecase;
  final ChangePhoneUsecase changePhoneUsecase;
  final ChangeEmailUsecase changeEmailUsecase;
  final ChangePhoneOtpUsecase changePhoneOtpUsecase;
  final ChangeEmailOtpUsecase changeEmailOtpUsecase;

  ProfileCubit(
      this.userProfileUsecase,
      this.changePhoneUsecase,
      this.changeEmailUsecase,
      this.changePhoneOtpUsecase,
      this.changeEmailOtpUsecase)
      : super(ProfileInitial());

  getProfile() async {
    emit(ProfileLoading());
    final result = await userProfileUsecase(NoParams());

    result.fold((l) => _emitFailure(l), (data) => emit(ProfileLoaded(data)));
  }

  changePhone(ChangePhoneParams params) async {
    emit(ChangeDataLoading());
    final result = await changePhoneUsecase(params);

    result.fold((l) => _emitFailure(l), (data) => emit(ChangeDataLoaded(data)));
  }

  changePhoneOtp(ChangeOtpParams params) async {
    emit(ChangeDataOtpLoading());
    final result = await changePhoneOtpUsecase(params);

    result.fold(
        (l) => _emitFailure(l), (data) => emit(ChangeDataOtpLoaded(data)));
  }

  changeEmail(ChangeEmailParams params) async {
    emit(ChangeDataLoading());
    final result = await changeEmailUsecase(params);

    result.fold((l) => _emitFailure(l), (data) => emit(ChangeDataLoaded(data)));
  }

  changeEmailOtp(ChangeOtpParams params) async {
    emit(ChangeDataOtpLoading());
    final result = await changeEmailOtpUsecase(params);

    result.fold(
        (l) => _emitFailure(l), (data) => emit(ChangeDataOtpLoaded(data)));
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(ProfileError(failure.message));
    } else if (failure is CacheFailure) {
      emit(ProfileError(failure.message));
    } else {
      emit(ProfileError(failure.message));
    }
  }
}
