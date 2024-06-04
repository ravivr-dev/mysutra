import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/booking_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/withdrawal_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_bookings_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_withdrawals_usecase.dart';

part 'earning_state.dart';

class EarningCubit extends Cubit<EarningState> {
  final GetBookingsUseCase getBookingsUseCase;
  final GetWithdrawalsUseCase getWithdrawalsUseCase;
  EarningCubit(
      {required this.getBookingsUseCase, required this.getWithdrawalsUseCase})
      : super(EarningInitial());

  int bookingAmount = 0;
  int earningAmount = 0;
  int commisionAmount = 0;
  List<WithdrawalData> withdrawals = [];
  List<BookingEntity> bookings = [];

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
}
