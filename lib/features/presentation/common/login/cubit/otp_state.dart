part of 'otp_cubit.dart';

sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class ResendLoginOtpSuccess extends OtpState {
  final String message;

  ResendLoginOtpSuccess(this.message);
}
final class ResendRegOtpSuccess extends OtpState {
  final String message;

  ResendRegOtpSuccess(this.message);
}

final class OtpSuccess extends OtpState {
  final OtpResponseUserModel data;

  OtpSuccess(this.data);
}

final class OtpError extends OtpState {
  final String error;

  OtpError(this.error);
}
