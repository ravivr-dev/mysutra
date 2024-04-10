import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class SpecialisationUsecase
    extends UseCase<List<SpecializationEntity>, GeneralPagination> {
  final UserRepository repo;

  SpecialisationUsecase(this.repo);

  @override
  Future<Either<Failure, List<SpecializationEntity>>> call(
      GeneralPagination params) async {
    return await repo.getSpecialisation(
        start: params.start, limit: params.limit);
  }
}

class GeneralPagination {
  final int? start;
  final int? limit;

  GeneralPagination({required this.start, required this.limit});
}
