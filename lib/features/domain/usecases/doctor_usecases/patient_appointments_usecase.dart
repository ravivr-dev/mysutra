import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class PatientAppointmentsUseCase
    extends UseCase<List<String?>, GetPatientAppointmentsParams> {
  final DoctorRepository _doctorRepository;

  PatientAppointmentsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<String?>>> call(
      GetPatientAppointmentsParams params) {
    return _doctorRepository.getPatientAppointments(params);
  }
}

class GetPatientAppointmentsParams {
  final String id;
  final int pageNumber;
  final int limit;

  GetPatientAppointmentsParams({
    required this.id,
    required this.pageNumber,
    required this.limit,
  });
}
