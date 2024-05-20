import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/follow_entity.dart';

class FollowUserUseCase extends UseCase<FollowEntity, FollowUserParams> {
  final UserRepository _userRepository;

  FollowUserUseCase(this._userRepository);

  @override
  Future<Either<Failure, FollowEntity>> call(FollowUserParams params) {
    return _userRepository.followUser(params);
  }
}

class FollowUserParams {
  final String userId;

  const FollowUserParams({required this.userId});
}
