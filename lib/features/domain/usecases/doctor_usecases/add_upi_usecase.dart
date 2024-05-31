import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class AddUpiUseCase
    extends UseCase<dynamic, String> {
  final DoctorRepository _doctorRepository;

  AddUpiUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, dynamic>> call(String params) {
    return _doctorRepository.createUpi(params);
  }
}