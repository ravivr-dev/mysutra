import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/doctor_entities/get_time_slots_response_data_entity.dart';

class GetTimeSlotsUseCase
    extends UseCase<GetTimeSlotsResponseEntity, GetTimeSlotsParams> {
  final DoctorRepository _doctorRepository;

  GetTimeSlotsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, GetTimeSlotsResponseEntity>> call(
      GetTimeSlotsParams params) {
    return _doctorRepository.getTimeSlots(params);
  }
}

class GetTimeSlotsParams {
  final int pagination;
  final int limit;

  const GetTimeSlotsParams({required this.pagination, required this.limit});
}
