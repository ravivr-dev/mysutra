import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class RateAppointmentUsecase extends UseCase<String, RateAppointmentParams> {
  final PatientRepository patientRepository;

  RateAppointmentUsecase(this.patientRepository);

  @override
  Future<Either<Failure, String>> call(RateAppointmentParams params) {
    return patientRepository.rateAppointment(params);
  }
}

class RateAppointmentParams {
  final String appointmentId;
  final String? doctorId;
  final int rating;

  RateAppointmentParams(
      {required this.appointmentId,
      required this.doctorId,
      required this.rating});
}
