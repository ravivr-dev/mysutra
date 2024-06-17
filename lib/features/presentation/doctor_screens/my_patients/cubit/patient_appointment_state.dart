part of 'patient_appointment_cubit.dart';

sealed class PatientAppointmentState {}

final class PatientAppointmentInitial extends PatientAppointmentState {}

final class PatientAppointmentLoading extends PatientAppointmentState {}

final class PatientAppointmentError extends PatientAppointmentState {
  final String error;

  PatientAppointmentError({required this.error});
}

final class PatientAppointmentLoaded extends PatientAppointmentState {}
