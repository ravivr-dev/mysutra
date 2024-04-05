import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class LoginUsecase extends UseCase<String, LoginParams> {
  final UserRepository repo;

  LoginUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await repo.login(
      countryCode: params.countryCode,
      phoneNumber: params.phoneNumber,
    );
  }
}

class LoginParams {
  final String countryCode;
  final String phoneNumber;

  LoginParams({
    required this.countryCode,
    required this.phoneNumber,
  });
}
