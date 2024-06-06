import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class UpdateProfileUsecase extends UseCase<String, UpdateProfileParams> {
  final UserRepository userRepository;

  UpdateProfileUsecase(this.userRepository);

  @override
  Future<Either<Failure, String>> call(UpdateProfileParams params) {
    return userRepository.updateProfile(params);
  }
}

class UpdateProfileParams {
  final String profilePic;

  UpdateProfileParams({required this.profilePic});
}
