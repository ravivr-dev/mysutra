import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class ChangePhoneOtpUsecase extends UseCase<String, ChangeOtpParams> {
  final UserRepository repo;

  ChangePhoneOtpUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(ChangeOtpParams params) async {
    return await repo.changePhoneOtp(
      otp: params.otp,
    );
  }
}

class ChangeOtpParams {
  final int otp;

  ChangeOtpParams({
    required this.otp,
  });
}