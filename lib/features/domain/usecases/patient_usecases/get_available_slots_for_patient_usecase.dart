import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/patient_entities/available_time_slot_entity.dart';

class GetAvailableSlotsForPatientUseCase
    extends UseCase<dynamic, GetAvailableSlotsForPatientParams> {
  final PatientRepository _patientRepository;

  GetAvailableSlotsForPatientUseCase(this._patientRepository);

  @override
  Future<Either<Failure, List<AvailableTimeSlotEntity>>> call(
      GetAvailableSlotsForPatientParams params) {
    return _patientRepository.getAvailableSlots(params);
  }
}

class GetAvailableSlotsForPatientParams {
  final String doctorID;
  final String date;

  GetAvailableSlotsForPatientParams({
    required this.doctorID,
    required this.date,
  });
}
