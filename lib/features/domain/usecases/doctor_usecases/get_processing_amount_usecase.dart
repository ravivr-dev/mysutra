import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class GetProcessingAmountUseCase
    extends UseCase<String, NoParams> {
  final DoctorRepository _doctorRepository;

  GetProcessingAmountUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, String>> call(
      NoParams params) {
    return _doctorRepository.getProcessingAmount();
  }
}