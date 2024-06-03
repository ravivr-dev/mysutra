import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/activate_deactivate_bank_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/add_upi_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_fund_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_payout_contact.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_bank_account_usecase.dart';

part 'bank_account_state.dart';

class BankAccountCubit extends Cubit<BankAccountState> {
  final GetBankAccountUseCase getBankAccountUseCase;
  final AddUpiUseCase addUpiUseCase;
  final CreateFundAccountUseCase createFundAccountUseCase;
  final CreatePayoutContactUseCase createPayoutContactUseCase;
  final ActivateDeactivateBankAccountUsecase
      activateDeactivateBankAccountUsecase;
  BankAccountCubit({
    required this.getBankAccountUseCase,
    required this.addUpiUseCase,
    required this.createFundAccountUseCase,
    required this.createPayoutContactUseCase,
    required this.activateDeactivateBankAccountUsecase,
  }) : super(BankAccountInitial());

  List<BankAccountEntity> accounts = [];

  void getData() async {
    emit(BankAccountLoading());
    final result = await getBankAccountUseCase.call(NoParams());
    result.fold((l) => emit(BankAccountError(l.message)), (data) {
      accounts.addAll(data);
      emit(BankAccountLoaded());
    });
  }

  void addUpi(String upi) async {
    emit(BankAccountButtonLoader());
    final result = await addUpiUseCase.call(upi);
    result.fold((l) => emit(BankAccountError(l.message)), (data) {
      emit(BankAccountUpiAdd());
    });
  }

  void createAccount(CreateFundAccountParams params) async {
    emit(BankAccountButtonLoader());
    final result = await createFundAccountUseCase.call(params);
    result.fold((l) => emit(BankAccountError(l.message)), (data) {
      emit(BankAccountBankAdd());
    });
  }

  void addContact(CreatePayoutContactParams params) async {
    emit(BankAccountButtonLoader());
    final result = await createPayoutContactUseCase.call(params);
    result.fold((l) => emit(BankAccountError(l.message)), (data) {
      emit(BankAccountContactAdd(data));
    });
  }

  void updateAccount(
      ActivateDeactivateBankAccountParams params, int index) async {
    emit(BankAccountButtonLoader());
    final result = await activateDeactivateBankAccountUsecase.call(params);
    result.fold((l) => emit(BankAccountError(l.message)), (data) {
      accounts[index].updateAccountStatus = params.activate;
      emit(BankAccountUpdate());
    });
  }

  stringForKey(String mobileNumber) {}
}
