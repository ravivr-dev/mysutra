import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';

class ConfirmAppointmentUseCase
    extends UseCase<dynamic, ConfirmAppointmentParams> {
  final PatientRepository _patientRepository;

  ConfirmAppointmentUseCase(this._patientRepository);

  @override
  Future<Either<Failure, dynamic>> call(ConfirmAppointmentParams params) {
    return _patientRepository.confirmAppointment(params);
  }
}

class ConfirmAppointmentParams {
  final int otp;
  final String token;

  ConfirmAppointmentParams({
    required this.otp,
    required this.token,
  });
}
