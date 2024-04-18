import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import '../usecases/doctor_usecases/update_time_slots_usecases.dart';

abstract class DoctorRepository {
  Future<Either<Failure, dynamic>> updateTimeSlots(UpdateTimeSlotsParams data);
}
