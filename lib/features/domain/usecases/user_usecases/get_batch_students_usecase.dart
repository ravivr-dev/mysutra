import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class GetBatchStudentsUsecase
    extends UseCase<List<UserProfileEntity>, PaginationParams> {
  final UserRepository repo;

  GetBatchStudentsUsecase(this.repo);

  @override
  Future<Either<Failure, List<UserProfileEntity>>> call(
      PaginationParams params) async {
    return await repo.getBatchStudents(
        pageNumber: params.pageNumber, limit: params.limit);
  }
}

class PaginationParams {
  final int? pageNumber;
  final int? limit;

  PaginationParams({this.pageNumber, this.limit});
}
