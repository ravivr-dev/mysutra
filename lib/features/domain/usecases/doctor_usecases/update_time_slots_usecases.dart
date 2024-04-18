import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/model/doctor_models/time_slot_model.dart';

class UpdateTimeSlotsUseCase extends UseCase<dynamic, UpdateTimeSlotsParams> {
  final DoctorRepository _doctorRepository;

  UpdateTimeSlotsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, dynamic>> call(UpdateTimeSlotsParams params) {
    return _doctorRepository.updateTimeSlots(params);
  }
}

class UpdateTimeSlotsParams {
  final DoctorTimeSlot doctorTimeSlot;

  const UpdateTimeSlotsParams({required this.doctorTimeSlot});
}
