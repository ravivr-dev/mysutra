import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_history_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class PaymentHistoryUseCase
    extends UseCase<List<PaymentHistoryEntity>, PaginationParams> {
  final PatientRepository _patientRepository;

  PaymentHistoryUseCase(this._patientRepository);

  @override
  Future<Either<Failure, List<PaymentHistoryEntity>>> call(
      PaginationParams params) {
    return _patientRepository.paymentHistory(params);
  }
}

class PaginationParams {
  final int pagination;
  final int limit;

  PaginationParams({this.pagination = 1, this.limit = 10});
}
