part of 'bank_account_cubit.dart';

sealed class BankAccountState {}

final class BankAccountInitial extends BankAccountState {}

final class BankAccountLoading extends BankAccountState {}

final class BankAccountError extends BankAccountState {
  final String error;

  BankAccountError(this.error);
}

final class BankAccountLoaded extends BankAccountState {}

final class BankAccountUpiAdd extends BankAccountState {}

final class BankAccountContactAdd extends BankAccountState {
  final String message;

  BankAccountContactAdd(this.message);
}

final class BankAccountBankAdd extends BankAccountState {}
