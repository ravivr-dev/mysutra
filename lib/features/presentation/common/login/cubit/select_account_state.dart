part of 'select_account_cubit.dart';

sealed class SelectAccountState {}

final class SelectAccountInitial extends SelectAccountState {}

final class SelectAccountLoading extends SelectAccountState {}

final class SelectAccountError extends SelectAccountState {
  final String error;

  SelectAccountError(this.error);
}

final class SelectAccountLoaded extends SelectAccountState {
  final List<UserData> data;

  SelectAccountLoaded(this.data);
}

final class SelectedAccountLoaded extends SelectAccountState {
  final UserData data;

  SelectedAccountLoaded(this.data);
}
