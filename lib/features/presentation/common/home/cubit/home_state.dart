part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
