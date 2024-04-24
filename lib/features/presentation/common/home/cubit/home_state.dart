part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}

final class GetAppointmentsLoadingState extends HomeState {}

final class GetAppointmentsErrorState extends HomeState {
  final String message;

  GetAppointmentsErrorState({required this.message});
}

final class GetAppointmentsSuccessState extends HomeState {
  List<AppointmentEntity> appointmentEntities;
  GetAppointmentsSuccessState({
    required this.appointmentEntities,
  });
}
