import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class CancelAppointmentsUseCase
    extends UseCase<String, CancelAppointmentParams> {
  final DoctorRepository _doctorRepository;

  CancelAppointmentsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, String>> call(CancelAppointmentParams params) {
    return _doctorRepository.cancelAppointment(params);
  }
}

class CancelAppointmentParams {
  final String appointmentId;

  const CancelAppointmentParams({required this.appointmentId});
}
