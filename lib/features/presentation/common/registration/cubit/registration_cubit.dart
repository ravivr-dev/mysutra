import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final SpecialisationUsecase specialisationUsecase;
  RegistrationCubit(this.specialisationUsecase) : super(RegistrationInitial());

  getSpecialisations(GeneralPagination params) async {
    final result = await specialisationUsecase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(SpecializationLoaded(data));
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(RegistrationError(failure.message));
    } else if (failure is CacheFailure) {
      emit(RegistrationError(failure.message));
    } else {
      emit(RegistrationError(failure.message));
    }
  }
}
