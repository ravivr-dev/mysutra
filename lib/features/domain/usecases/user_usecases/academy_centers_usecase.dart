import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class AcademyCenterUsecase
    extends UseCase<List<AcademyCenter>, GetAcademyParams> {
  final UserRepository repo;

  AcademyCenterUsecase(this.repo);

  @override
  Future<Either<Failure, List<AcademyCenter>>> call(
      GetAcademyParams params) async {
    return await repo.getAcademyCentres(
      pageNumber: params.pageNumber,
      limit: params.limit,
    );
  }
}

class GetAcademyParams {
  final int? pageNumber;
  final int? limit;

  GetAcademyParams({this.pageNumber, this.limit});
}
