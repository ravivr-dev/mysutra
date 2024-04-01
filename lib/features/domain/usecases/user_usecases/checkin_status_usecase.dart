import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/checkin_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class CheckinStatusUsecase extends UseCase<CheckinEntity, PaginationParams> {
  final UserRepository repo;

  CheckinStatusUsecase(this.repo);

  @override
  Future<Either<Failure, CheckinEntity>> call(PaginationParams params) async {
    return await repo.getCheckinStatus(
      pageNumber: params.pageNumber,
      limit: params.limit,
    );
  }
}

class PaginationParams {
  final int? pageNumber;
  final int? limit;

  PaginationParams({this.pageNumber, this.limit});
}
