import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_data_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class GetFollowingUseCase
    extends UseCase<List<UserDataEntity>, GetFollowingParams> {
  final UserRepository _userRepository;

  GetFollowingUseCase(this._userRepository);

  @override
  Future<Either<Failure, List<UserDataEntity>>> call(
      GetFollowingParams params) {
    return _userRepository.getFollowings(params);
  }
}

class GetFollowingParams {
  final int pagination;
  final int limit;
  final String? role;

  const GetFollowingParams({
    required this.pagination,
    required this.limit,
    required this.role,
  });
}
