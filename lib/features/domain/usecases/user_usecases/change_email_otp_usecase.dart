import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_otp_usecase.dart';

class ChangeEmailOtpUsecase extends UseCase<String, ChangeOtpParams> {
  final UserRepository repo;

  ChangeEmailOtpUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(ChangeOtpParams params) async {
    return await repo.changeEmailOtp(
      otp: params.otp,
    );
  }
}