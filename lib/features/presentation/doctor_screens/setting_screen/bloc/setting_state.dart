part of 'setting_cubit.dart';

sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class UpdateTimeSlotLoadingState extends SettingState {}

final class UpdateTimeSlotErrorState extends SettingState {
  final String message;
  UpdateTimeSlotErrorState({required this.message});
}

final class UpdateTimeSlotSuccessState extends SettingState {
  UpdateTimeSlotSuccessState();
}

final class UpdateAboutOrFeesLoadingState extends SettingState {}

final class UpdateAboutOrFeesSuccessState extends SettingState {}

final class UpdateAboutOrFeesErrorState extends SettingState {
  final String message;
  UpdateAboutOrFeesErrorState({required this.message});
}

final class GetTimeSlotsLoadingState extends SettingState {}

final class GetTimeSlotsSuccessState extends SettingState {
  List<GetTimeSlotsResponseDataEntity> list;
  GetTimeSlotsSuccessState({
    required this.list,
  });
}

final class GetTimeSlotsErrorState extends SettingState {
  final String message;
  GetTimeSlotsErrorState({required this.message});
}
