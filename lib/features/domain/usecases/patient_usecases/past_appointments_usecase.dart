import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/past_appointment_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

import '../../../../core/usecase/usecase.dart';

class PastAppointmentUseCase extends UseCase<
    List<PastAppointmentResponseEntity>, PastAppointmentsParams> {
  final PatientRepository _patientRepository;

  PastAppointmentUseCase(this._patientRepository);

  @override
  Future<Either<Failure, List<PastAppointmentResponseEntity>>> call(
      PastAppointmentsParams params) {
    return _patientRepository.pastAppointments(params);
  }
}

class PastAppointmentsParams {
  final int pagination;
  final int limit;

  const PastAppointmentsParams({required this.pagination, required this.limit});
}
