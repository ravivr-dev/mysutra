import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/booking_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/withdrawal_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/checkout_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_bank_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_bookings_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_processing_amount_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_withdrawals_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';

part 'earning_state.dart';

class EarningCubit extends Cubit<EarningState> {
  final GetBankAccountUseCase getBankAccountUseCase;
  final GetBookingsUseCase getBookingsUseCase;
  final GetWithdrawalsUseCase getWithdrawalsUseCase;
  final CheckoutUseCase checkoutUseCase;
  final GetProcessingAmountUseCase getProcessingAmountUseCase;
  EarningCubit({
    required this.getBankAccountUseCase,
    required this.checkoutUseCase,
    required this.getBookingsUseCase,
    required this.getWithdrawalsUseCase,
    required this.getProcessingAmountUseCase,
  }) : super(EarningInitial());

  num bookingAmount = 0;
  num earningAmount = 0;
  num commisionAmount = 0;
  num processingAmount = 0;
  List<WithdrawalData> withdrawals = [];
  List<BookingEntity> bookings = [];
  List<BankAccountEntity> accounts = [];

  void getBookingData(GetPayoutParams params) async {
    emit(EarningLoading());
    final result = await getBookingsUseCase.call(params);
    result.fold((l) => emit(EarningError(l.message)), (data) {
      bookings = data;
      emit(EarningBooking(data));
    });
  }

  void getWithdrawalData(GetPayoutParams params) async {
    emit(EarningLoading());
    final result = await getWithdrawalsUseCase.call(params);
    result.fold((l) => emit(EarningError(l.message)), (data) {
      bookingAmount = data.booking ?? 0;
      earningAmount = data.earnings ?? 0;
      commisionAmount = data.commision ?? 0;
      withdrawals = data.data;
      emit(EarningWithdraw(data));
    });
  }

  void getAccounts() async {
      emit(EarningLoading());
    final result = await getBankAccountUseCase
        .call(GeneralPagination(start: 1, limit: 50));
    result.fold((l) => emit(EarningError(l.message)), (data) {
      accounts.addAll(data);
      emit(EarningAccountsLoaded());
    });
  }

  void checkout(CheckoutParams params) async {
    emit(EarningWithdrawalLoader());
    final result = await checkoutUseCase.call(params);
    result.fold((l) => emit(EarningError(l.message)), (data) {
      emit(EarningCheckout());
    });
  }

  void getProcessingAmount() async {
    final result = await getProcessingAmountUseCase.call(NoParams());
    result.fold((l) => emit(EarningError(l.message)), (data) {
      processingAmount = double.parse(data).round();
      emit(EarningProcessingAmount());
    });
  }
}
