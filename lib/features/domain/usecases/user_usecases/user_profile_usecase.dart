import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class UserProfileUsecase extends UseCase<UserProfileEntity, NoParams> {
  final UserRepository repo;

  UserProfileUsecase(this.repo);

  @override
  Future<Either<Failure, UserProfileEntity>> call(NoParams params) async {
    return await repo.getProfile();
  }
}
