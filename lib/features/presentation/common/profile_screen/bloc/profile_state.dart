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

final class GetDoctorFollowingLoadingState extends ProfileState {}

final class GetDoctorFollowingLoadedState extends ProfileState {
  final List<FollowerEntity> followers;

  GetDoctorFollowingLoadedState({required this.followers});
}

final class GetDoctorFollowingErrorState extends ProfileState {
  final String message;

  GetDoctorFollowingErrorState({required this.message});
}
