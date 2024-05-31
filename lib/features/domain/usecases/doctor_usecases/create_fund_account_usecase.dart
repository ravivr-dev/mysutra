import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class CreateFundAccountUseCase
    extends UseCase<dynamic, CreateFundAccountParams> {
  final DoctorRepository _doctorRepository;

  CreateFundAccountUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, dynamic>> call(CreateFundAccountParams params) {
    return _doctorRepository.createFundAccount(params);
  }
}

class CreateFundAccountParams {
  final String name;
  final String ifsc;
  final int accountNumber;

  CreateFundAccountParams({required this.name, required this.ifsc, required this.accountNumber});


}
