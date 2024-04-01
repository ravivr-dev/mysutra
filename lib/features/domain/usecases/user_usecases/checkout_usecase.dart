import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class CheckoutUsecase extends UseCase<String, NoParams> {
  final UserRepository repo;

  CheckoutUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repo.checkOut();
  }
}