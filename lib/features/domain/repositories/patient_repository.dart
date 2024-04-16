import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

abstract class PatientRepository {
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors(
      SearchDoctorParams data);
}
