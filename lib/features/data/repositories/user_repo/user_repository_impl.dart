import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/user_datasource.dart';

import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final LocalDataSource localDataSource;
  final UserDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, String>> login(
      {required String countryCode, required String phoneNumber}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.login(
          countryCode: countryCode,
          phoneNumber: phoneNumber,
        );

        return Right(result.message ?? "");
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
