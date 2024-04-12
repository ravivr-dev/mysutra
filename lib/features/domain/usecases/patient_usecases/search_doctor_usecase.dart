import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class SearchDoctorUsecase extends UseCase<List<DoctorEntity>, SearchDoctorParams> {
  final PatientRepository repo;

  SearchDoctorUsecase(this.repo);

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(SearchDoctorParams params) async {
    return await repo.searchDoctors(params);
  }
}

class SearchDoctorParams {
  final String search;
  final String specializationId;
  final int reviews;
  final int experience;
  final int start;
  final int limit;

  SearchDoctorParams({
    required this.search,
    required this.specializationId,
    required this.reviews,
    required this.experience,
    required this.start,
    required this.limit,
  });
}
