import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';

class GetBankAccountUseCase extends UseCase<List<BankAccountEntity>, GeneralPagination> {
  final DoctorRepository _doctorRepository;

  GetBankAccountUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<BankAccountEntity>>> call(GeneralPagination params) {
    return _doctorRepository.getAccounts(params);
  }
}
