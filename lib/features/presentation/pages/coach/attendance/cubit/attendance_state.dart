part of 'attendance_cubit.dart';

sealed class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class GetBatchStudentsLoading extends AttendanceState {}

class GetBatchStudentsLoaded extends AttendanceState {
  final List<UserProfileEntity> data;

  GetBatchStudentsLoaded(this.data);
}

class MarkAttendanceLoading extends AttendanceState {}

class MarkAttendanceLoaded extends AttendanceState {
  final String data;

  MarkAttendanceLoaded(this.data);
}

class AttendanceError extends AttendanceState {
  final String error;

  AttendanceError(this.error);
}
