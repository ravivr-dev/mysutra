import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateAboutOrFeesUseCase
    extends UseCase<dynamic, UpdateAboutOrFeesParams> {
  final DoctorRepository _doctorRepository;

  UpdateAboutOrFeesUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, dynamic>> call(UpdateAboutOrFeesParams params) {
    return _doctorRepository.updateAboutOrFess(params);
  }
}

class UpdateAboutOrFeesParams {
  final int? fees;
  final String? about;

  const UpdateAboutOrFeesParams({required this.fees, required this.about});
}
