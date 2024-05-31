import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_history_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_history_usecase.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  final PaymentHistoryUseCase paymentHistoryUsecase;

  PaymentHistoryCubit({required this.paymentHistoryUsecase})
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
}
