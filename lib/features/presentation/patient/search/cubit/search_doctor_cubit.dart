import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

part 'search_doctor_state.dart';

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  final SearchDoctorUsecase searchDoctorUsecase;
  SearchDoctorCubit(this.searchDoctorUsecase) : super(SearchDoctorInitial());

  getData(SearchDoctorParams params) async {
    emit(SearchDoctorLoading());
    final result = await searchDoctorUsecase(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(SearchDoctorLoaded(data));
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(SearchDoctorError(failure.message));
    } else if (failure is CacheFailure) {
      emit(SearchDoctorError(failure.message));
    } else {
      emit(SearchDoctorError(failure.message));
    }
  }
}
