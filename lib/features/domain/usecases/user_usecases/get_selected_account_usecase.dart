import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class GetSelectedAccountUsecase extends UseCase<UserData, String> {
  final UserRepository repo;

  GetSelectedAccountUsecase(this.repo);

  @override
  Future<Either<Failure, UserData>> call(String params) async {
    return await repo.getSelectedUserAccounts(params);
  }
}
