import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import '../../entities/user_entities/my_profile_entity.dart';

class GetProfileDetailsUseCase {
  final UserRepository repo;

  GetProfileDetailsUseCase(this.repo);

  Future<Either<Failure, MyProfileEntity>> call() async {
    return await repo.getProfileDetails();
  }
}
