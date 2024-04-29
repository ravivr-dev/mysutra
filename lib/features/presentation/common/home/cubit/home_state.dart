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

final class GetUserDetailsLoadingState extends HomeState {}

final class GetUserDetailsErrorState extends HomeState {
  final String message;

  GetUserDetailsErrorState({
    required this.message,
  });
}

final class GetUserDetailsSuccessState extends HomeState {
  UserEntity entity;

  GetUserDetailsSuccessState({
    required this.entity,
  });
}

final class GetDoctorAppointmentLoadingState extends HomeState {}

final class GetDoctorAppointmentErrorState extends HomeState {
  final String message;

  GetDoctorAppointmentErrorState({
    required this.message,
  });
}

final class GetDoctorAppointmentSuccessState extends HomeState {
  GetDoctorAppointmentEntity entity;

  GetDoctorAppointmentSuccessState({
    required this.entity,
  });
}

final class GetAvailableSlotsLoadingState extends HomeState {}

final class GetAvailableSlotsErrorState extends HomeState {
  final String message;

  GetAvailableSlotsErrorState({required this.message});
}

final class GetAvailableSlotsLoadedState extends HomeState {}
