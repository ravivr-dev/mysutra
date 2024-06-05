import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_history_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_payment_receipt_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_history_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/download_pdf_usecase.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  final PaymentHistoryUseCase paymentHistoryUsecase;
  final GetPaymentReceiptUsecase getPaymentReceiptUsecase;
  final DownloadPdfUseCase downloadPdfUseCase;


  PaymentHistoryCubit(
      {
        required this.downloadPdfUseCase,
        required this.getPaymentReceiptUsecase,
      required this.paymentHistoryUsecase})
      : super(PaymentHistoryInitial());

  List<PaymentHistoryEntity> paymentHistoty = [];
  bool getMoreData = true;

  void getData(PaginationParams params) async {
    if (!getMoreData) {
      return;
    }
    emit(PaymentHistoryLoading());
    final result = await paymentHistoryUsecase.call(params);
    result.fold((l) => emit(PaymentHistoryError(l.message)), (data) {
      paymentHistoty.addAll(data);
      if (data.length < 10) {
        getMoreData = false;
      }
      emit(PaymentHistoryLoaded(data));
    });
  }

  void getPaymentReceiptUrl({required String paymentId}) async {
    final result = await getPaymentReceiptUsecase
        .call(GetPaymentReceiptParams(paymentId: paymentId));

    result.fold((l) => emit(GetPaymentReceiptError(error: l.message)),
        (r) => emit(GetPaymentReceiptSuccess(url: r)));
  }

  void downloadPdf(String url) async {
    final result = await downloadPdfUseCase.call(DownloadPdfParams(url: url));
    result.fold((l) => emit(DownloadPdfErrorState(error:l.message)),
            (r) => emit(DownloadPdfSuccessState(filePath: r)));
  }
}
