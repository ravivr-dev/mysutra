import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class CheckoutUseCase extends UseCase<dynamic, CheckoutParams> {
  final DoctorRepository _doctorRepository;

  CheckoutUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, dynamic>> call(CheckoutParams params) {
    return _doctorRepository.checkout(params);
  }
}

class CheckoutParams {
  final String accountId;
  final String mode;
  final int amount;

  CheckoutParams(
      {required this.accountId, required this.mode, required this.amount});
}
