import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class LogOutUsecase extends UseCase<dynamic, NoParams> {
  final UserRepository repo;

  LogOutUsecase(this.repo);

  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    return await repo.logout();
  }
}
