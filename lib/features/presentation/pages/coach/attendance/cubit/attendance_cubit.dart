import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_batch_students_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/mark_attendance_usecase.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetBatchStudentsUsecase getBatchStudentsUsecase;
  final MarkAttendanceUsecase markAttendanceUsecase;

  AttendanceCubit(this.getBatchStudentsUsecase, this.markAttendanceUsecase)
      : super(AttendanceInitial());

  getBatchStudents(int? limit, int? pageNumber) async {
    final result = await getBatchStudentsUsecase(
        PaginationParams(limit: limit, pageNumber: pageNumber));

    result.fold(
        (l) => _emitFailure(l), (data) => emit(GetBatchStudentsLoaded(data)));
  }

  markAttendance(String? date, List<String>? studentIds) async {
    final result =
        await markAttendanceUsecase(MarkAttendanceParams(date, studentIds));

    result.fold((l) => _emitFailure(l), (data) => MarkAttendanceLoaded(data));
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(AttendanceError(failure.message));
    } else if (failure is CacheFailure) {
      emit(AttendanceError(failure.message));
    } else {
      emit(AttendanceError(failure.message));
    }
  }
}
