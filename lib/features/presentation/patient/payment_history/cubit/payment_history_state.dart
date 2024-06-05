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

final class GetPaymentReceiptLoading extends PaymentHistoryState {}

final class GetPaymentReceiptSuccess extends PaymentHistoryState {
  final String url;

  GetPaymentReceiptSuccess({required this.url});
}

final class GetPaymentReceiptError extends PaymentHistoryState {
  final String error;

  GetPaymentReceiptError({required this.error});
}

final class DownloadPdfErrorState extends PaymentHistoryState {
  final String error;

  DownloadPdfErrorState({required this.error});
}

final class DownloadPdfSuccessState extends PaymentHistoryState {
  final String filePath;

  DownloadPdfSuccessState({required this.filePath});
}
