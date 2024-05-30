import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_data_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class GetFollowersUsecase
    extends UseCase<List<UserDataEntity>, GetFollowersParams> {
  final UserRepository userRepository;

  GetFollowersUsecase(this.userRepository);

  @override
  Future<Either<Failure, List<UserDataEntity>>> call(
      GetFollowersParams params) {
    return userRepository.getFollowers(params);
  }
}

class GetFollowersParams {
  final int pagination;
  final int limit;

  GetFollowersParams({required this.pagination, required this.limit});
}
