part of 'search_doctor_cubit.dart';

sealed class SearchDoctorState {}

final class SearchDoctorInitial extends SearchDoctorState {}

final class SearchDoctorLoading extends SearchDoctorState {}

final class SearchDoctorError extends SearchDoctorState {
  final String error;

  SearchDoctorError(this.error);
}

final class SearchDoctorLoaded extends SearchDoctorState {
  final List<DoctorEntity> data;

  SearchDoctorLoaded(this.data);
}
