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
  final int followedDoctorIndex;
  FollowDoctorSuccessState({
    required this.followEntity,
    required this.followedDoctorIndex,
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
