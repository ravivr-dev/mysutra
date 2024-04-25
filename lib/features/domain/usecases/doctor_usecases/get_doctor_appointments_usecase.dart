import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/get_doctor_appointment_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class GetDoctorAppointmentsUseCase
    extends UseCase<GetDoctorAppointmentEntity, GetDoctorAppointmentsParams> {
  final DoctorRepository _doctorRepository;

  GetDoctorAppointmentsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, GetDoctorAppointmentEntity>> call(
      GetDoctorAppointmentsParams params) {
    return _doctorRepository.getAppointments(params);
  }
}

class GetDoctorAppointmentsParams {
  final String date;
  final int pagination;
  final int limit;

  const GetDoctorAppointmentsParams(
      {required this.date, required this.pagination, required this.limit});
}
