import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_order_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class PaymentOrderUseCase
    extends UseCase<PaymentOrderEntity, PaymentOrderParams> {
  final PatientRepository _patientRepository;

  PaymentOrderUseCase(this._patientRepository);

  @override
  Future<Either<Failure, PaymentOrderEntity>> call(PaymentOrderParams params) {
    return _patientRepository.paymentOrder(params);
  }
}

class PaymentOrderParams {
  final String id;
  final int amount;

  PaymentOrderParams({required this.id, required this.amount});
}
