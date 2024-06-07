part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileDetailsLoadingState extends ProfileState {}

final class GetProfileDetailsSuccessState extends ProfileState {
  final MyProfileEntity entity;

  GetProfileDetailsSuccessState({required this.entity});
}

final class GetProfileDetailsErrorState extends ProfileState {
  final String message;

  GetProfileDetailsErrorState({
    required this.message,
  });
}

final class GetPatientLoadingState extends ProfileState {}

final class GetPatientSuccessState extends ProfileState {
  final List<PatientEntity> patients;

  GetPatientSuccessState({
    required this.patients,
  });
}

final class GetPatientErrorState extends ProfileState {
  final String message;

  GetPatientErrorState({
    required this.message,
  });
}

final class GetFollowingLoadingState extends ProfileState {}

final class GetFollowingLoadedState extends ProfileState {
  final List<UserDataEntity> myFollowings;

  GetFollowingLoadedState({required this.myFollowings});
}

final class GetFollowingErrorState extends ProfileState {
  final String message;

  GetFollowingErrorState({required this.message});
}

final class ChangePhoneNumberLoadingState extends ProfileState {}

final class ChangePhoneNumberLoadedState extends ProfileState {
  final String message;

  ChangePhoneNumberLoadedState({required this.message});
}

final class ChangePhoneNumberErrorState extends ProfileState {
  final String message;

  ChangePhoneNumberErrorState({required this.message});
}

final class ChangeEmailLoadingState extends ProfileState {}

final class ChangeEmailLoadedState extends ProfileState {
  final String message;

  ChangeEmailLoadedState({required this.message});
}

final class ChangeEmailErrorState extends ProfileState {
  final String message;

  ChangeEmailErrorState({required this.message});
}

final class VerifyChangeLoadingState extends ProfileState {}

final class VerifyChangeLoadedState extends ProfileState {
  final String message;

  VerifyChangeLoadedState({required this.message});
}

final class VerifyChangeErrorState extends ProfileState {
  final String message;

  VerifyChangeErrorState({required this.message});
}

final class GetFollowersLoading extends ProfileState {}

final class GetFollowersLoaded extends ProfileState {
  final List<UserDataEntity> followers;

  GetFollowersLoaded({required this.followers});
}

final class GetFollowersError extends ProfileState {
  final String error;

  GetFollowersError({required this.error});
}

final class UpdateProfileLoading extends ProfileState {}

final class UpdateProfileSuccess extends ProfileState {
  final String message;

  UpdateProfileSuccess({required this.message});
}

final class UpdateProfileError extends ProfileState {
  final String error;

  UpdateProfileError({required this.error});
}

final class UploadPictureLoading extends ProfileState {}

final class UploadPictureSuccess extends ProfileState {
  final UploadDocModel model;

  UploadPictureSuccess({required this.model});
}

final class UploadPictureError extends ProfileState {
  final String error;

  UploadPictureError({required this.error});
}
