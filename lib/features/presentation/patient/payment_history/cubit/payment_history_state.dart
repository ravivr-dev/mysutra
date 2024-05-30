part of 'payment_history_cubit.dart';

sealed class PaymentHistoryState {}

final class PaymentHistoryInitial extends PaymentHistoryState {}

final class PaymentHistoryLoading extends PaymentHistoryState {}

final class PaymentHistoryLoaded extends PaymentHistoryState {
  final List<PaymentHistoryEntity> data;

  PaymentHistoryLoaded(this.data);
}

final class PaymentHistoryError extends PaymentHistoryState {
  final String error;

  PaymentHistoryError(this.error);
}
