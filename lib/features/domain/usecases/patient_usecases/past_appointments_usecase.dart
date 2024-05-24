import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/appointment_entity.dart';

class PastAppointmentUseCase
    extends UseCase<List<AppointmentEntity>, PastAppointmentsParams> {
  final PatientRepository _patientRepository;

  PastAppointmentUseCase(this._patientRepository);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(
      PastAppointmentsParams params) {
    return _patientRepository.pastAppointments(params);
  }
}

class PastAppointmentsParams {
  final int pagination;
  final int limit;

  const PastAppointmentsParams({required this.pagination, required this.limit});
}
