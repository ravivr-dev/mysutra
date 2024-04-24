import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/appointment_entity.dart';

class GetAppointmentUseCase extends UseCase<List<AppointmentEntity>, GetAppointmentsParams> {
  final PatientRepository _patientRepository;

  GetAppointmentUseCase(this._patientRepository);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(GetAppointmentsParams params) {
    return _patientRepository.getAppointments(params);
  }
}

class GetAppointmentsParams {
  final String date;
  final int pagination;
  final int limit;

  const GetAppointmentsParams(
      {required this.date, required this.pagination, required this.limit});
}
