import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class GetPaymentReceiptUsecase
    extends UseCase<String, GetPaymentReceiptParams> {
  final PatientRepository patientRepository;

  GetPaymentReceiptUsecase(this.patientRepository);

  @override
  Future<Either<Failure, String>> call(GetPaymentReceiptParams params) {
    return patientRepository.getPaymentReceipt(params);
  }
}

class GetPaymentReceiptParams {
  final String paymentId;

  GetPaymentReceiptParams({required this.paymentId});
}
