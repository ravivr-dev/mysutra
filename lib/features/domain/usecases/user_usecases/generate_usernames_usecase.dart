//
import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import '../../entities/user_entities/generate_username_entity.dart';

class GenerateUsernamesUseCase extends UseCase<GenerateUsernameEntity, String> {
  final UserRepository repo;

  GenerateUsernamesUseCase(this.repo);

  @override
  Future<Either<Failure, GenerateUsernameEntity>> call(String userName) async {
    return repo.generateUsernames(userName);
  }
}
