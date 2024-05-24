part of 'registration_cubit.dart';

sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class SpecializationLoaded extends RegistrationState {
  final List<SpecializationEntity> data;

  SpecializationLoaded(this.data);
}

final class RegistrationSuccess extends RegistrationState {
  final String message;

  RegistrationSuccess(this.message);
}

final class UploadDocumentSuccessState extends RegistrationState {
  final UploadDocModel data;
  final XFile file;
  final bool isPdf;

  UploadDocumentSuccessState(this.data, this.file, this.isPdf);
}

final class RegistrationError extends RegistrationState {
  final String error;

  RegistrationError(this.error);
}

final class GenerateUserNamesLoadingState extends RegistrationState {}

final class GenerateUserNamesSuccessState extends RegistrationState {
  final GenerateUsernameEntity entity;

  GenerateUserNamesSuccessState({required this.entity});
}

final class GenerateUserNamesErrorState extends RegistrationState {
  final String message;

  GenerateUserNamesErrorState({
    required this.message,
  });
}

final class UploadDocLoading extends RegistrationState {}
