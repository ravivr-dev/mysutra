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