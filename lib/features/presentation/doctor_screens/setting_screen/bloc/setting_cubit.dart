import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/model/doctor_models/time_slot_model.dart';
import '../../../../domain/usecases/doctor_usecases/update_time_slots_usecases.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final UpdateTimeSlotsUseCase updateTimeSlotsUseCase;

  SettingCubit({
    required this.updateTimeSlotsUseCase,
  }) : super(SettingInitial());

  void updateTimeSlot(DoctorTimeSlot doctorTimeSlot) async {
    emit(UpdateTimeSlotLoadingState());
    final result = await updateTimeSlotsUseCase
        .call(UpdateTimeSlotsParams(doctorTimeSlot: doctorTimeSlot));
    result.fold((l) => emit(UpdateTimeSlotErrorState(message: l.message)),
        (r) => emit(UpdateTimeSlotSuccessState()));
  }
}
