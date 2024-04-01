part of 'my_batches_cubit.dart';

sealed class MyBatchesState {}

final class MyBatchesInitial extends MyBatchesState {}

final class TrainingProgramLoaded extends MyBatchesState {
  final List<TrainingProgram> data;

  TrainingProgramLoaded(this.data);
}

final class MyBatchError extends MyBatchesState {
  final String error;

  MyBatchError(this.error);
}
