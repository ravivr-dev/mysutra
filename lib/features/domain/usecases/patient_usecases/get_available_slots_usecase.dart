import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/available_time_slot_entity.dart';

class GetAvailableSlotsUseCase
    extends UseCase<dynamic, GetAvailableSlotsParams> {
  final PatientRepository _patientRepository;

  GetAvailableSlotsUseCase(this._patientRepository);

  @override
  Future<Either<Failure, List<AvailableTimeSlotEntity>>> call(
      GetAvailableSlotsParams params) {
    return _patientRepository.getAvailableSlots(params);
  }
}

class GetAvailableSlotsParams {
  final String doctorID;
  final String date;

  GetAvailableSlotsParams({
    required this.doctorID,
    required this.date,
  });
}
