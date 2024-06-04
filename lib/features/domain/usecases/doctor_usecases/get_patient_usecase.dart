import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import '../../../../core/usecase/usecase.dart';

class GetPatientUseCase extends UseCase<List<PatientEntity>, GetPatientsParams> {
  final DoctorRepository _doctorRepository;

  GetPatientUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<PatientEntity>>> call(GetPatientsParams params) {
    return _doctorRepository.getPatients(params);
  }
}

class GetPatientsParams {
  final int pagination;
  final int limit;

  const GetPatientsParams({required this.pagination, required this.limit});
}
