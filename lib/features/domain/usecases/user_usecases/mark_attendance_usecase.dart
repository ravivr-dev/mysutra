import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class MarkAttendanceUsecase extends UseCase<String, MarkAttendanceParams> {
  final UserRepository repo;

  MarkAttendanceUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(MarkAttendanceParams params) async {
    return await repo.markAttendance(params.date, params.studentIds);
  }
}

class MarkAttendanceParams {
  final String? date;
  final List<String>? studentIds;

  MarkAttendanceParams(this.date, this.studentIds);
}
