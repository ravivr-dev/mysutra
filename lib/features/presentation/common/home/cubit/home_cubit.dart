import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_cancel_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_reschedule_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_available_slots_for_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_doctor_appointments_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_home_data_usecase.dart';

import '../../../../domain/entities/doctor_entities/get_doctor_appointment_entity.dart';
import '../../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../../domain/entities/user_entities/video_room_response_entity.dart';
import '../../../../domain/usecases/patient_usecases/get_appointments_usecase.dart';
import '../../../../domain/usecases/user_usecases/get_video_room_id_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalDataSource localDataSource;
  final GetAppointmentUseCase getAppointmentUseCase;
  final GetHomeDataUseCase getHomeDataUseCase;
  final GetDoctorAppointmentsUseCase getDoctorAppointmentUseCase;
  final DoctorCancelAppointmentsUseCase doctorCancelAppointmentsUseCase;
  final DoctorRescheduleAppointmentsUseCase doctorRescheduleAppointmentsUseCase;
  final GetAvailableSlotsForDoctorUseCase getAvailableSlotsForDoctorUseCase;
  final GetVideoRoomIdUseCase getVideoRoomIdUseCase;

  HomeCubit({
    required this.localDataSource,
    required this.getAppointmentUseCase,
    required this.getHomeDataUseCase,
    required this.getDoctorAppointmentUseCase,
    required this.doctorCancelAppointmentsUseCase,
    required this.getAvailableSlotsForDoctorUseCase,
    required this.doctorRescheduleAppointmentsUseCase,
    required this.getVideoRoomIdUseCase,
  }) : super(HomeInitial());

  void getAppointments(
      {required String date,
      required int pagination,
      required int limit}) async {
    emit(GetAppointmentsLoadingState());
    final result = await getAppointmentUseCase.call(GetAppointmentsParams(
        date: date, pagination: pagination, limit: limit));
    result.fold((l) => emit(GetAppointmentsErrorState(message: l.message)),
        (r) => emit(GetAppointmentsSuccessState(appointmentEntities: r)));
  }

  void getHomeData() async {
    emit(GetHomeDataLoadingState());
    final result = await getHomeDataUseCase.call();
    result.fold((l) => emit(GetHomeDataErrorState(message: l.message)),
        (r) => emit(GetHomeDataSuccessState(entity: r)));
  }

  void getDoctorAppointments({
    required String date,
    required int pagination,
    required int limit,
  }) async {
    emit(GetDoctorAppointmentLoadingState());
    final result = await getDoctorAppointmentUseCase.call(
        GetDoctorAppointmentsParams(
            date: date, pagination: pagination, limit: limit));
    result.fold((l) => emit(GetDoctorAppointmentErrorState(message: l.message)),
        (r) => emit(GetDoctorAppointmentSuccessState(entity: r)));
  }

  void cancelAppointmentForDoctor({required String appointmentId}) async {
    final result = await doctorCancelAppointmentsUseCase
        .call(CancelAppointmentParams(appointmentId: appointmentId));

    result.fold((l) => emit(CancelAppointmentErrorState(message: l.message)),
        (r) => emit(CancelAppointmentLoadedState(message: r)));
  }

  void getAvailableTimeSlotsForDoctors({required String date}) async {
    final result = await getAvailableSlotsForDoctorUseCase
        .call(GetAvailableSlotsForDoctorParams(date: date));

    result.fold((l) => emit(GetAvailableSlotsErrorState(message: l.message)),
        (r) => emit(GetAvailableSlotsLoadedState(availableSlots: r)));
  }

  void rescheduleAppointmentForDoctor(
      {required String appointmentId,
      required String date,
      required String time}) async {
    final result = await doctorRescheduleAppointmentsUseCase.call(
        RescheduleAppointmentParams(
            date: date, time: time, appointmentId: appointmentId));

    result.fold(
        (l) => emit(RescheduleAppointmentErrorState(message: l.message)),
        (r) => emit(RescheduleAppointmentLoadedState(message: r)));
  }

  void getVideoRoomId(
      {required String roomId,
      required String remoteUserId,
      required String currentUserId,
      required String appointmentId,
      required bool isVideoCall,
      required String name}) async {
    final result = await getVideoRoomIdUseCase
        .call(GetVideoRoomIdUseCaseParams(appointmentId: appointmentId));

    result.fold(
        (l) => emit(GetVideoRoomErrorState(message: l.message)),
        (r) => emit(GetVideoRoomSuccessState(
            data: r,
            isVideoCall: isVideoCall,
            name: name,
            roomId: roomId,
            remoteUserId: remoteUserId,
            currentUserId: currentUserId,
            appointmentId: appointmentId)));
  }

// FutureOr<void> _emitFailure(
//   Failure failure,
// ) async {
//   if (failure is ServerFailure) {
//     emit(HomeError(failure.message));
//   } else if (failure is CacheFailure) {
//     emit(HomeError(failure.message));
//   } else {
//     emit(HomeError(failure.message));
//   }
// }
}
