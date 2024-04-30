import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';

class CancelAppointmentUseCase
    extends UseCase<dynamic, CancelAppointmentParams> {
  final PatientRepository _patientRepository;

  CancelAppointmentUseCase(this._patientRepository);

  @override
  Future<Either<Failure, dynamic>> call(CancelAppointmentParams params) {
    return _patientRepository.cancelAppointment(params);
  }
}

class CancelAppointmentParams {
  final String appointmentId;

  CancelAppointmentParams({
    required this.appointmentId,
  });
}
