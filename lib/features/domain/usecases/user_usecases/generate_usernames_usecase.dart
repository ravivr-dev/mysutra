//
import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import '../../entities/user_entities/generate_username_entity.dart';

class GenerateUsernamesUseCase {
  final UserRepository repo;

  GenerateUsernamesUseCase(this.repo);

  Future<Either<Failure, GenerateUsernameEntity>> call() async {
    return repo.generateUsernames();
  }
}
