import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';

import '../../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../../domain/usecases/patient_usecases/get_appointments_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalDataSource localDataSource;
  final GetAppointmentUseCase getAppointmentUseCase;

  HomeCubit({
    required this.localDataSource,
    required this.getAppointmentUseCase,
  }) : super(HomeInitial());

  void getAppointments(
      {required String date,
      required int pagination,
      required int limit}) async {
    emit(GetAppointmentsLoadingState());
    final result = await getAppointmentUseCase.call(GetAppointmentsParams(
        date: date, pagination: pagination, limit: limit));
    result.fold((l) => emit(GetAppointmentsErrorState(message: l.message)),
        (r) => emit(GetAppointmentsSuccessState(appointmentEntities: r)));
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(HomeError(failure.message));
    } else if (failure is CacheFailure) {
      emit(HomeError(failure.message));
    } else {
      emit(HomeError(failure.message));
    }
  }
}
