
import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class GetRasorpayKeyUseCase
    extends UseCase<String, NoParams> {
  final PatientRepository _patientRepository;

  GetRasorpayKeyUseCase(this._patientRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _patientRepository.getRasorpayKey();
  }
}