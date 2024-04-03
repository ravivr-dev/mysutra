part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class AcademyLoading extends LoginState {}

final class AcademyLoaded extends LoginState {
  final List<AcademyCenter> academies;

  AcademyLoaded(this.academies);
}

final class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

final class LoginLoading extends LoginState {}

final class OtpLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);
}
