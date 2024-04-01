import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class ChangePhoneUsecase extends UseCase<String, ChangePhoneParams> {
  final UserRepository repo;

  ChangePhoneUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(ChangePhoneParams params) async {
    return await repo.changePhone(
      countryCode: params.countryCode,
      phoneNumber: params.phoneNumber,
    );
  }
}

class ChangePhoneParams {
  final String countryCode;
  final int phoneNumber;

  ChangePhoneParams({
    required this.countryCode,
    required this.phoneNumber,
  });
}