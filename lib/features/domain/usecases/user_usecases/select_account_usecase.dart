import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class SelectAccountUsecase extends UseCase<List<UserData>, NoParams> {
  final UserRepository repo;

  SelectAccountUsecase({required this.repo});

  @override
  Future<Either<Failure, List<UserData>>> call(NoParams params) async {
    return await repo.getUserAccounts();
  }
}
