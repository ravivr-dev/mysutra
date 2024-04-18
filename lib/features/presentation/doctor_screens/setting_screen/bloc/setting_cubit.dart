import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/model/doctor_models/time_slot_model.dart';
import '../../../../domain/usecases/doctor_usecases/update_about_or_fees_usecase.dart';
import '../../../../domain/usecases/doctor_usecases/update_time_slots_usecases.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final UpdateTimeSlotsUseCase updateTimeSlotsUseCase;
  final UpdateAboutOrFeesUseCase updateAboutOrFeesUseCase;

  SettingCubit({
    required this.updateTimeSlotsUseCase,
    required this.updateAboutOrFeesUseCase,
  }) : super(SettingInitial());

  void updateTimeSlot(DoctorTimeSlot doctorTimeSlot) async {
    emit(UpdateTimeSlotLoadingState());
    final result = await updateTimeSlotsUseCase
        .call(UpdateTimeSlotsParams(doctorTimeSlot: doctorTimeSlot));
    result.fold((l) => emit(UpdateTimeSlotErrorState(message: l.message)),
        (r) => emit(UpdateTimeSlotSuccessState()));
  }

  void updateAboutOrFees({int? fees, String? about}) async {
    emit(UpdateAboutOrFeesLoadingState());
    final result = await updateAboutOrFeesUseCase
        .call(UpdateAboutOrFeesParams(fees: fees, about: about));
    result.fold((l) => emit(UpdateAboutOrFeesErrorState(message: l.message)),
        (r) => emit(UpdateAboutOrFeesSuccessState()));
  }
}
