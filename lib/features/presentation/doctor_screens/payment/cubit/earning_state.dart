part of 'earning_cubit.dart';

sealed class EarningState {}

final class EarningInitial extends EarningState {}

final class EarningLoading extends EarningState {}

final class EarningError extends EarningState {
  final String error;

  EarningError(this.error);
}

final class EarningWithdraw extends EarningState {
  final WithdrawalEntity data;

  EarningWithdraw(this.data);
}

final class EarningBooking extends EarningState {
  final List<BookingEntity> data;

  EarningBooking(this.data);
}

final class EarningAccountsLoaded extends EarningState {}

final class EarningCheckout extends EarningState {}

final class EarningWithdrawalLoader extends EarningState {}
