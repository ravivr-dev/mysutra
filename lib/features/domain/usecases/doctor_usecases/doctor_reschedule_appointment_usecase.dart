import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class DoctorRescheduleAppointmentsUseCase
    extends UseCase<String, RescheduleAppointmentParams> {
  final DoctorRepository _doctorRepository;

  DoctorRescheduleAppointmentsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, String>> call(RescheduleAppointmentParams params) {
    return _doctorRepository.rescheduleAppointment(params);
  }
}

class RescheduleAppointmentParams {
  final String appointmentId;
  final String date;
  final String time;

  const RescheduleAppointmentParams(
      {required this.date, required this.time, required this.appointmentId});
}
