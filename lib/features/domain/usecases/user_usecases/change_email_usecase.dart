import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class ChangeEmailUsecase extends UseCase<String, ChangeEmailParams> {
  final UserRepository repo;

  ChangeEmailUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(ChangeEmailParams params) async {
    return await repo.changeEmail(
      email: params.email,
    );
  }
}

class ChangeEmailParams {
  final String email;

  ChangeEmailParams({
    required this.email,
  });
}