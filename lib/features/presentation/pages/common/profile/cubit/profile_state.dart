part of 'profile_cubit.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileEntity data;

  ProfileLoaded(this.data);
}

class ChangeDataInitial extends ProfileState {}

class ChangeDataLoading extends ProfileState {}

class ChangeDataLoaded extends ProfileState {
  final String message;

  ChangeDataLoaded(this.message);
}

class ChangeDataOtpInitial extends ProfileState {}

class ChangeDataOtpLoading extends ProfileState {}

class ChangeDataOtpLoaded extends ProfileState {
  final String message;

  ChangeDataOtpLoaded(this.message);
}


class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
