import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class OtpUsecase extends UseCase<OtpModel, int> {
  final UserRepository repo;
  OtpUsecase(this.repo);

  @override
  Future<Either<Failure, OtpModel>> call(int params) async {
    return await repo.verifyOtp(params);
  }
}
