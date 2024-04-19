import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/schedule_appointment_response_entity.dart';
import '../../../domain/entities/patient_entities/available_time_slot_entity.dart';
import '../../../domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_available_slots_usecase.dart';
import '../../../domain/usecases/patient_usecases/schedule_appointment_usecase.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final GetAvailableSlotsUseCase getAvailableSlotsUseCase;
  final ScheduleAppointmentUseCase scheduleAppointmentUseCase;
  final ConfirmAppointmentUseCase confirmAppointmentUseCase;

  AppointmentCubit({
    required this.getAvailableSlotsUseCase,
    required this.scheduleAppointmentUseCase,
    required this.confirmAppointmentUseCase,
  }) : super(AppointmentInitial());

  void getAvailableSlots(
      {required String doctorId, required String date}) async {
    emit(GetAvailableAppointmnetLoadingState());
    final result = await getAvailableSlotsUseCase
        .call(GetAvailableSlotsParams(doctorID: doctorId, date: date));
    result.fold(
        (l) => emit(GetAvailableAppointmentErrorState(message: l.message)),
        (r) => emit(GetAvailableAppointmentSuccessState(timeSlots: r)));
  }

  void scheduleAppointment({required ScheduleAppointmentParams data}) async {
    emit(ScheduleAppointmentLoadingState());
    final result = await scheduleAppointmentUseCase.call(data);
    result.fold((l) => emit(ScheduleAppointmentErrorState(message: l.message)),
        (r) => emit(ScheduleAppointmentSuccessState(entity: r)));
  }

  void confirmAppointment({required ConfirmAppointmentParams data}) async {
    emit(ConfirmAppointmentLoadingState());
    final result = await confirmAppointmentUseCase.call(data);
    result.fold((l) => emit(ConfirmAppointmentErrorState(message: l.message)),
        (r) => emit(ConfirmAppointmentSuccessState()));
  }
}
