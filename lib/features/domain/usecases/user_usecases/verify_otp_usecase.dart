import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';

class VerifyOtpUsecase extends UseCase<String, LoginParams> {
  final UserRepository repo;

  VerifyOtpUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await repo.sendOtp(
      academy: params.academy,
      countryCode: params.countryCode,
      phoneNumber: params.phoneNumber,
      otp: params.otp!,
    );
  }
}
