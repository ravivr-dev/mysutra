import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class ActivateDeactivateBankAccountUsecase
    extends UseCase<dynamic, ActivateDeactivateBankAccountParams> {
  final DoctorRepository _doctorRepository;

  ActivateDeactivateBankAccountUsecase(this._doctorRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      ActivateDeactivateBankAccountParams params) {
    return _doctorRepository.activateDeactivateBankAccount(params);
  }
}

class ActivateDeactivateBankAccountParams {
  final String accountId;
  final bool activate;

  ActivateDeactivateBankAccountParams(
      {required this.accountId, required this.activate});
}
