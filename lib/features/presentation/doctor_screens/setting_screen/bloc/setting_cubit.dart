import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/model/doctor_models/time_slot_model.dart';
import '../../../../domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import '../../../../domain/usecases/doctor_usecases/get_time_slots_usecase.dart';
import '../../../../domain/usecases/doctor_usecases/update_about_or_fees_usecase.dart';
import '../../../../domain/usecases/doctor_usecases/update_time_slots_usecases.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final UpdateTimeSlotsUseCase updateTimeSlotsUseCase;
  final UpdateAboutOrFeesUseCase updateAboutOrFeesUseCase;
  final GetTimeSlotsUseCase getTimeSlotsUseCase;

  SettingCubit({
    required this.updateTimeSlotsUseCase,
    required this.updateAboutOrFeesUseCase,
    required this.getTimeSlotsUseCase,
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

  void getTimeSlots({int pagination = 1, int limit = 10}) async {
    emit(GetTimeSlotsLoadingState());
    final result = await getTimeSlotsUseCase
        .call(GetTimeSlotsParams(pagination: pagination, limit: limit));
    result.fold((l) => emit(GetTimeSlotsErrorState(message: l.message)),
        (r) => emit(GetTimeSlotsSuccessState(list: r)));
  }
}
