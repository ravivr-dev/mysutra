import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';

class GetDoctorDetailsUseCase
    extends UseCase<DoctorEntity, GetDoctorDetailsParams> {
  final PatientRepository _patientRepository;

  GetDoctorDetailsUseCase(this._patientRepository);

  @override
  Future<Either<Failure, DoctorEntity>> call(GetDoctorDetailsParams params) {
    return _patientRepository.getDoctorDetails(params);
  }
}

class GetDoctorDetailsParams {
  final String doctorID;

  GetDoctorDetailsParams({
    required this.doctorID,
  });
}
