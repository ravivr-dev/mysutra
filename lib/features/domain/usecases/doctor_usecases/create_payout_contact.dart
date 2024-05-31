import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class CreatePayoutContactUseCase
    extends UseCase<String, CreatePayoutContactParams> {
  final DoctorRepository _doctorRepository;

  CreatePayoutContactUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, String>> call(CreatePayoutContactParams params) {
    return _doctorRepository.createPayoutContact(params);
  }
}

class CreatePayoutContactParams {
  final String name;
  final String email;
  final String contact;

  CreatePayoutContactParams(
      {required this.name, required this.email, required this.contact});
}
