import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class ClearMessagesUseCase extends UseCase<String, String> {
  final UserRepository repo;

  ClearMessagesUseCase(this.repo);

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repo.clearMessage(params);
  }
}
