part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}

final class AcademyCentersLoaded extends HomeState {
  final List<AcademyCenter> data;

  AcademyCentersLoaded(this.data);
}

final class MyBatchesLoaded extends HomeState {
  final List<BatchItem> data;

  MyBatchesLoaded(this.data);
}

final class ChangeAcademy extends HomeState {
  final AcademyCenter data;

  ChangeAcademy(this.data);
}

final class UserProfileState extends HomeState {
  final UserProfileEntity data;

  UserProfileState(this.data);
}
