part of 'appointment_cubit.dart';

@immutable
sealed class AppointmentState {}

final class AppointmentInitial extends AppointmentState {}

final class ScheduleAppointmentLoadingState extends AppointmentState {}

final class ScheduleAppointmentSuccessState extends AppointmentState {
  final ScheduleAppointmentResponseEntity entity;
  ScheduleAppointmentSuccessState({
    required this.entity,
  });
}

final class ScheduleAppointmentErrorState extends AppointmentState {
  final String message;
  ScheduleAppointmentErrorState({
    required this.message,
  });
}

final class GetAvailableAppointmnetLoadingState extends AppointmentState {}

final class GetAvailableAppointmentErrorState extends AppointmentState {
  final String message;
  GetAvailableAppointmentErrorState({
    required this.message,
  });
}

final class GetAvailableAppointmentSuccessState extends AppointmentState {
  final List<AvailableTimeSlotEntity> timeSlots;
  GetAvailableAppointmentSuccessState({
    required this.timeSlots,
  });
}

final class ConfirmAppointmentLoadingState extends AppointmentState {}

final class ConfirmAppointmentSuccessState extends AppointmentState {}

final class ConfirmAppointmentErrorState extends AppointmentState {
  final String message;
  ConfirmAppointmentErrorState({
    required this.message,
  });
}

final class CancelAppointmentLoadingState extends AppointmentState {}

final class CancelAppointmentSuccessState extends AppointmentState {}

final class CancelAppointmentErrorState extends AppointmentState {
  final String message;
  CancelAppointmentErrorState({
    required this.message,
  });
}

final class PastAppointmentLoadingState extends AppointmentState {}

final class PastAppointmentSuccessState extends AppointmentState {
  final List<AppointmentEntity> appointmentEntities;

  PastAppointmentSuccessState({
    required this.appointmentEntities,
  });
}

final class PastAppointmentErrorState extends AppointmentState {
  final String message;

  PastAppointmentErrorState({
    required this.message,
  });
}
