
import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class MyBatchesUsecase
    extends UseCase<List<BatchItem>, GetBatchesParams> {
  final UserRepository repo;

  MyBatchesUsecase(this.repo);

  @override
  Future<Either<Failure, List<BatchItem>>> call(
      GetBatchesParams params) async {
    return await repo.getMyBatches(
      pageNumber: params.pageNumber,
      limit: params.limit,
    );
  }
}


class GetBatchesParams {
  final int? pageNumber;
  final int? limit;

  GetBatchesParams({this.pageNumber, this.limit});
}
