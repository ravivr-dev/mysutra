import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';


class VerifyChangeEmailUseCase {
  final UserRepository repo;

  VerifyChangeEmailUseCase(this.repo);

  Future<Either<Failure, String>> call(int params) async {
    return repo.verifyChangeEmail(params);
  }
}



