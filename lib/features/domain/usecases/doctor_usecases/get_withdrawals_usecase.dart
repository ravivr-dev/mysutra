import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/withdrawal_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class GetWithdrawalsUseCase extends UseCase<WithdrawalEntity, GetPayoutParams> {
  final DoctorRepository _doctorRepository;

  GetWithdrawalsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, WithdrawalEntity>> call(GetPayoutParams params) {
    return _doctorRepository.getWithdrawals(params);
  }
}

class GetPayoutParams {
  final String? earningType;
  final String date;
  final int pagination;
  final int limit;

  GetPayoutParams(
      {this.earningType,
      required this.date,
      this.pagination = 1,
      this.limit = 10});
}
