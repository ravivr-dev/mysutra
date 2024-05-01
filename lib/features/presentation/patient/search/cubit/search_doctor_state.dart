part of 'search_doctor_cubit.dart';

sealed class SearchDoctorState {}

final class SearchDoctorInitial extends SearchDoctorState {}

final class SearchDoctorLoading extends SearchDoctorState {}

final class SearchDoctorError extends SearchDoctorState {
  final String error;

  SearchDoctorError(this.error);
}

final class FollowDoctorLoading extends SearchDoctorState {}

final class FollowDoctorSuccessState extends SearchDoctorState {
  final FollowEntity followEntity;
  final int? followedDoctorIndex;
  final String doctorId;
  FollowDoctorSuccessState({
    required this.followEntity,
    required this.followedDoctorIndex,
    required this.doctorId,
  });
}

final class FolowDoctorErrorState extends SearchDoctorState {
  final String message;
  FolowDoctorErrorState({
    required this.message,
  });
}

final class SearchDoctorLoaded extends SearchDoctorState {
  final List<DoctorEntity> data;

  SearchDoctorLoaded(this.data);
}

final class GetDoctorDetailsLoadingState extends SearchDoctorState {}

final class GetDoctorDetailsSuccessState extends SearchDoctorState {
  final DoctorEntity doctorEntity;
  GetDoctorDetailsSuccessState({
    required this.doctorEntity,
  });
}

final class GetDoctorDetailsErrorState extends SearchDoctorState {
  final String message;
  GetDoctorDetailsErrorState({
    required this.message,
  });
}
