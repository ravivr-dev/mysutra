import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/available_time_slot_entity.dart';

class GetAvailableSlotsForDoctorUseCase
    extends UseCase<dynamic, GetAvailableSlotsForDoctorParams> {
  final DoctorRepository _doctorRepository;

  GetAvailableSlotsForDoctorUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<AvailableTimeSlotEntity>>> call(
      GetAvailableSlotsForDoctorParams params) {
    return _doctorRepository.getAvailableSlots(params);
  }
}

class GetAvailableSlotsForDoctorParams {
  final String date;

  GetAvailableSlotsForDoctorParams({
    required this.date,
  });
}
