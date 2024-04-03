part of 'otp_cubit.dart';

sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class ResendOtpSuccess extends OtpState {
  final String message;

  ResendOtpSuccess(this.message);
}

final class OtpSuccess extends OtpState {
  final String message;

  OtpSuccess(this.message);
}

final class OtpError extends OtpState {
  final String error;

  OtpError(this.error);
}