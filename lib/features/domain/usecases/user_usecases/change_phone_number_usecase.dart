import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class ChangePhoneNumberUseCase {
  final UserRepository repo;

  ChangePhoneNumberUseCase(this.repo);

  Future<Either<Failure, String>> call(ChangePhoneNumberParams params) async {
    return repo.changePhoneNumber(params);
  }
}

class ChangePhoneNumberParams {
  final String countryCode;
  final int newNumber;

  ChangePhoneNumberParams({required this.newNumber, required this.countryCode});
}
