import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';


class ChangeEmailUseCase {
  final UserRepository repo;

  ChangeEmailUseCase(this.repo);

  Future<Either<Failure, String>> call(ChangeEmailParams params) async {
    return repo.changeEmail(params);
  }
}

class ChangeEmailParams{
  final String email;

  ChangeEmailParams({required this.email});
}


