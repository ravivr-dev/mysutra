import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_selected_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/select_account_usecase.dart';

part 'select_account_state.dart';

class SelectAccountCubit extends Cubit<SelectAccountState> {
  final SelectAccountUsecase selectAccountUsecase;
  final GetSelectedAccountUsecase selectedAccountUsecase;
  SelectAccountCubit(this.selectAccountUsecase, this.selectedAccountUsecase)
      : super(SelectAccountInitial());

  getData() async {
    emit(SelectAccountLoading());
    final result = await selectAccountUsecase.call(NoParams());

    result.fold((l) => _emitFailure(l), (data) {
      emit(SelectAccountLoaded(data));
    });
  }

  getSelectedAccountData(String id) async {
    emit(SelectAccountLoading());
    final result = await selectedAccountUsecase.call(id);

    result.fold((l) => _emitFailure(l), (data) {
      emit(SelectedAccountLoaded(data));
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(SelectAccountError(failure.message));
    } else if (failure is CacheFailure) {
      emit(SelectAccountError(failure.message));
    } else {
      emit(SelectAccountError(failure.message));
    }
  }
}
