import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(
      {required String countryCode, required String phoneNumber});

  Future<Either<Failure, UserModel>> verifyOtp(int otp);

  Future<Either<Failure, List<UserData>>> getUserAccounts();
}
