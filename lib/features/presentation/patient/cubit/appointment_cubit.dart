import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/past_appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_order_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/schedule_appointment_response_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_rasorpay_key_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_order_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/rate_appointment_usecase.dart';

import '../../../domain/entities/patient_entities/available_time_slot_entity.dart';
import '../../../domain/usecases/patient_usecases/cancel_appointment_usecase.dart';
import '../../../domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_available_slots_for_patient_usecase.dart';
import '../../../domain/usecases/patient_usecases/past_appointments_usecase.dart';
import '../../../domain/usecases/patient_usecases/schedule_appointment_usecase.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final GetAvailableSlotsForPatientUseCase getAvailableSlotsUseCase;
  final ScheduleAppointmentUseCase scheduleAppointmentUseCase;
  final ConfirmAppointmentUseCase confirmAppointmentUseCase;
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final PastAppointmentUseCase pastAppointmentUseCase;
  final GetRasorpayKeyUseCase getRasorpayKeyUseCase;
  // final PaymentOrderUseCase paymentOrderUsercase;
  final RateAppointmentUsecase rateAppointmentUsecase;

  AppointmentCubit({
    required this.rateAppointmentUsecase,
    required this.getAvailableSlotsUseCase,
    required this.scheduleAppointmentUseCase,
    required this.confirmAppointmentUseCase,
    required this.cancelAppointmentUseCase,
    required this.pastAppointmentUseCase,
    required this.getRasorpayKeyUseCase,
    // required this.paymentOrderUsercase,
  }) : super(AppointmentInitial());

  void getAvailableSlotsForPatients(
      {required String doctorId, required String date}) async {
    emit(GetAvailableAppointmnetLoadingState());
    final result = await getAvailableSlotsUseCase.call(
        GetAvailableSlotsForPatientParams(doctorID: doctorId, date: date));
    result.fold(
        (l) => emit(GetAvailableAppointmentErrorState(message: l.message)),
        (r) => emit(GetAvailableAppointmentSuccessState(timeSlots: r)));
  }

  /// we only need (appointmentId,date,time) while updating appointment so don't pass anything else
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
        (r) => emit(ConfirmAppointmentSuccessState(id: r)));
  }

  void cancelAppointment({required String appointmentId}) async {
    emit(CancelAppointmentLoadingState());
    final result = await cancelAppointmentUseCase
        .call(CancelAppointmentParams(appointmentId: appointmentId));
    result.fold((l) => emit(CancelAppointmentErrorState(message: l.message)),
        (r) => emit(CancelAppointmentSuccessState()));
  }

  void getPastAppointments(
      {required int pagination, required int limit}) async {
    emit(PastAppointmentLoadingState());
    final result = await pastAppointmentUseCase
        .call(PastAppointmentsParams(pagination: pagination, limit: limit));
    result.fold((l) => emit(PastAppointmentErrorState(message: l.message)),
        (r) => emit(PastAppointmentSuccessState(appointmentEntities: r)));
  }

  void getRazorpayKey( {
  required String orderId}) async {
    final result = await getRasorpayKeyUseCase.call(NoParams());
    result.fold((l) => emit(RazorpayKeyErrorState(message: l.message)),
        (r) => emit(RazorpayKeySuccessState(key: r, orderId: orderId)));
  }

  // void getOrderId(PaymentOrderParams params) async {
  //   final result = await paymentOrderUsercase.call(params);
  //   result.fold((l) => emit(PaymentErrorState(message: l.message)),
  //       (r) => emit(PaymentSuccessState(data: r)));
  // }

  void rateAppointment(RateAppointmentParams params) async {
    final result = await rateAppointmentUsecase.call(params);
    result.fold((l) => emit(RateAppointmentError(error: l.message)),
        (r) => emit(RateAppointmentSuccess(message: r)));
  }
}
