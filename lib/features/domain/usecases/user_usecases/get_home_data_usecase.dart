import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';

import '../../entities/user_entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetHomeDataUseCase {
  final UserRepository _userRepository;

  GetHomeDataUseCase(this._userRepository);

  Future<Either<Failure, UserEntity>> call() {
    return _userRepository.getHomeData();
  }
}
