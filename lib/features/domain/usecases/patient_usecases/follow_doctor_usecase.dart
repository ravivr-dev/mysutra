import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/follow_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';

class FollowDoctorUseCase extends UseCase<FollowEntity, FollowDoctorParams> {
  final PatientRepository _patientRepository;

  FollowDoctorUseCase(this._patientRepository);

  @override
  Future<Either<Failure, FollowEntity>> call(FollowDoctorParams params) {
    return _patientRepository.followDoctor(params);
  }
}

class FollowDoctorParams {
  final String doctorId;

  const FollowDoctorParams({required this.doctorId});
}
