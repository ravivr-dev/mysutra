import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/training_program_usecase.dart';

part 'my_batches_state.dart';

class MyBatchesCubit extends Cubit<MyBatchesState> {
  final TrainingProgramUsecase trainingProgramUsecase;

  MyBatchesCubit(
    this.trainingProgramUsecase,
  ) : super(MyBatchesInitial());

  getTrainingPrograms(String id) async {
    final result = await trainingProgramUsecase(id);
    result.fold((l) => _emitFailure(l), (data) {
      emit(
        TrainingProgramLoaded(data),
      );
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(MyBatchError(failure.message));
    } else if (failure is CacheFailure) {
      emit(MyBatchError(failure.message));
    } else {
      emit(MyBatchError(failure.message));
    }
  }
}
