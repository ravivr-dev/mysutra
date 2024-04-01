import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class TrainingProgramUsecase extends UseCase<List<TrainingProgram>, String> {
  final UserRepository repo;

  TrainingProgramUsecase(this.repo);

  @override
  Future<Either<Failure, List<TrainingProgram>>> call(String params) async {
    return await repo.getTrainingProgram(params);
  }
}
