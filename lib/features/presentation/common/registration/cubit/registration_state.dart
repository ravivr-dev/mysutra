part of 'registration_cubit.dart';

sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class SpecializationLoaded extends RegistrationState {
  final List<SpecializationItem> data;

  SpecializationLoaded(this.data);
}

final class RegistrationSuccess extends RegistrationState {
  final String message;

  RegistrationSuccess(this.message);
}

final class RegistrationError extends RegistrationState {
  final String error;

  RegistrationError(this.error);
}
