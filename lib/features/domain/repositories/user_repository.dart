import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(
      {required String countryCode, required String phoneNumber});
}
