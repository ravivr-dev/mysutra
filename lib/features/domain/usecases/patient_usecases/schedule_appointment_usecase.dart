import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/schedule_appointment_response_entity.dart';

class ScheduleAppointmentUseCase extends UseCase<
    ScheduleAppointmentResponseEntity, ScheduleAppointmentParams> {
  final PatientRepository _patientRepository;

  ScheduleAppointmentUseCase(this._patientRepository);

  @override
  Future<Either<Failure, ScheduleAppointmentResponseEntity>> call(
      ScheduleAppointmentParams params) {
    return _patientRepository.scheduleAppointment(params);
  }
}

class ScheduleAppointmentParams {
  final String? doctorID;
  final String date;
  final String time;
  final String? patientName;
  final String? patientAge;
  final String? patientGender;
  final int? patientNumber;
  final String? patientEmail;
  // final String? patientProblem;
  final String? appointmentId;

  ScheduleAppointmentParams({
    required this.doctorID,
    required this.date,
    required this.patientNumber,
    required this.patientAge,
    required this.patientGender,
    required this.patientEmail,
    required this.patientName,
    // required this.patientProblem,
    required this.time,
    required this.appointmentId,
  });
}
