import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_number_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_followers_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_following_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/update_profile_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_change_phone_number_usecase.dart';
import '../../../../domain/entities/patient_entities/patient_entity.dart';
import '../../../../domain/entities/user_entities/my_profile_entity.dart';
import '../../../../domain/entities/user_entities/user_data_entity.dart';
import '../../../../domain/usecases/doctor_usecases/get_patient_usecase.dart';
import '../../../../domain/usecases/user_usecases/get_profile_details_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetFollowersUsecase getFollowersUsecase;
  final GetProfileDetailsUseCase getProfileDetailsUseCase;
  final GetPatientUseCase getPatientUseCaseUseCase;
  final GetFollowingUseCase getFollowingUseCase;
  final ChangeEmailUseCase changeEmailUseCase;
  final ChangePhoneNumberUseCase changePhoneNumberUseCase;
  final VerifyChangeEmailUseCase verifyChangeEmailUseCase;
  final VerifyChangePhoneNumberUseCase verifyChangePhoneNumberUseCase;
  final UpdateProfileUsecase updateProfileUsecase;
  final UploadDocumentUsecase uploadDocumentUsecase;

  ProfileCubit({
    required this.uploadDocumentUsecase,
    required this.updateProfileUsecase,
    required this.getFollowersUsecase,
    required this.changeEmailUseCase,
    required this.changePhoneNumberUseCase,
    required this.verifyChangeEmailUseCase,
    required this.verifyChangePhoneNumberUseCase,
    required this.getFollowingUseCase,
    required this.getProfileDetailsUseCase,
    required this.getPatientUseCaseUseCase,
  }) : super(ProfileInitial());

  void getProfileDetails() async {
    emit(GetProfileDetailsLoadingState());
    final result = await getProfileDetailsUseCase.call();
    result.fold((l) => emit(GetProfileDetailsErrorState(message: l.message)),
        (r) => emit(GetProfileDetailsSuccessState(entity: r)));
  }

  void getFollowing(
      {String? role, required int pagination, required int limit}) async {
    emit(GetFollowingLoadingState());
    final result = await getFollowingUseCase.call(
        GetFollowingParams(pagination: pagination, limit: limit, role: role));
    result.fold((l) => emit(GetFollowingErrorState(message: l.message)),
        (r) => emit(GetFollowingLoadedState(myFollowings: r)));
  }

  void getPatients({
    required int pagination,
    required int limit,
  }) async {
    emit(GetPatientLoadingState());
    final result = await getPatientUseCaseUseCase
        .call(GetPatientsParams(pagination: pagination, limit: limit));
    result.fold((l) => emit(GetPatientErrorState(message: l.message)),
        (r) => emit(GetPatientSuccessState(patients: r)));
  }

  void changeEmail({required String newEmail}) async {
    emit(ChangeEmailLoadingState());
    final result =
        await changeEmailUseCase.call(ChangeEmailParams(email: newEmail));
    result.fold((l) => emit(ChangeEmailErrorState(message: l.message)),
        (r) => emit(ChangeEmailLoadedState(message: r)));
  }

  void verifyChangeEmail({required int otp}) async {
    emit(VerifyChangeLoadingState());
    final result = await verifyChangeEmailUseCase.call(otp);

    result.fold((l) => emit(VerifyChangeErrorState(message: l.message)),
        (r) => emit(VerifyChangeLoadedState(message: r)));
  }

  void changePhoneNumber({required String cc, required int phoneNumber}) async {
    emit(ChangePhoneNumberLoadingState());
    final result = await changePhoneNumberUseCase
        .call(ChangePhoneNumberParams(countryCode: cc, newNumber: phoneNumber));
    result.fold((l) => emit(ChangePhoneNumberErrorState(message: l.message)),
        (r) => emit(ChangeEmailLoadedState(message: r)));
  }

  void verifyChangePhoneNumber({required int otp}) async {
    emit(VerifyChangeLoadingState());
    final result = await verifyChangePhoneNumberUseCase.call(otp);
    result.fold((l) => emit(VerifyChangeErrorState(message: l.message)),
        (r) => emit(VerifyChangeLoadedState(message: r)));
  }

  void getFollowers({required int pagination, required int limit}) async {
    emit(GetFollowersLoading());
    final result = await getFollowersUsecase
        .call(GetFollowersParams(pagination: pagination, limit: limit));

    result.fold((l) => emit(GetFollowersError(error: l.message)),
        (r) => emit(GetFollowersLoaded(followers: r)));
  }

  void uploadPicture({required XFile file}) async {
    final result = await uploadDocumentUsecase.call(File(file.path));

    result.fold((l) => emit(UploadPictureError(error: l.message)),
        (r) => emit(UploadPictureSuccess(model: r)));
  }

  void updateProfile({required String profilePic}) async {
    final result = await updateProfileUsecase
        .call(UpdateProfileParams(profilePic: profilePic));

    result.fold((l) => emit(UpdateProfileError(error: l.message)),
        (r) => emit(UpdateProfileSuccess(message: r)));
  }
}
