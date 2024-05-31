import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class GetAccountUseCase extends UseCase<List<BankAccountEntity>, NoParams> {
  final DoctorRepository _doctorRepository;

  GetAccountUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<BankAccountEntity>>> call(NoParams params) {
    return _doctorRepository.getAccounts();
  }
}
