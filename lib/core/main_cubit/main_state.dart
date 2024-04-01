part of 'main_cubit.dart';

sealed class MainState {}

final class AppStarted extends MainState {}

final class LoggedIn extends MainState {}

final class LoggedOut extends MainState {}
