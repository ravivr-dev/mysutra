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

final class GetHomeDataLoadingState extends HomeState {}

final class GetHomeDataErrorState extends HomeState {
  final String message;

  GetHomeDataErrorState({
    required this.message,
  });
}

final class GetHomeDataSuccessState extends HomeState {
  UserEntity entity;

  GetHomeDataSuccessState({
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

final class GetAvailableSlotsLoadedState extends HomeState {
  final List<AvailableTimeSlotEntity> availableSlots;

  GetAvailableSlotsLoadedState({required this.availableSlots});
}

final class CancelAppointmentLoadingState extends HomeState {}

final class CancelAppointmentErrorState extends HomeState {
  final String message;

  CancelAppointmentErrorState({required this.message});
}

final class CancelAppointmentLoadedState extends HomeState {
  final String message;

  CancelAppointmentLoadedState({required this.message});
}

final class RescheduleAppointmentLoadingState extends HomeState {}

final class RescheduleAppointmentErrorState extends HomeState {
  final String message;

  RescheduleAppointmentErrorState({required this.message});
}

final class RescheduleAppointmentLoadedState extends HomeState {
  final String message;

  RescheduleAppointmentLoadedState({required this.message});
}

final class GetVideoRoomSuccessState extends HomeState {
  final VideoRoomResponseEntity data;
  final bool isVideoCall;
  final String name;
  final String roomId;
  final String remoteUserId;
  final String currentUserId;

  GetVideoRoomSuccessState({
    required this.data,
    required this.isVideoCall,
    required this.name,
    required this.roomId,
    required this.remoteUserId,
    required this.currentUserId,
  });
}

final class GetVideoRoomLoadingState extends HomeState {}

final class GetVideoRoomErrorState extends HomeState {
  final String message;

  GetVideoRoomErrorState({required this.message});
}
