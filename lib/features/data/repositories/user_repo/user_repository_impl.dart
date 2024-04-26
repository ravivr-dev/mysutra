import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/user_datasource.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/data/repositories/user_repo/user_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/generate_username_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/my_profile_entity.dart';

import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';

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
        if (result.token != null) {
          localDataSource.setAccessToken(result.token!);
        }

        return Right(result.message ?? "");
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> verifyOtp(int otp) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.verifyOtp(otp);
        if (result.data != null) {
          localDataSource.setAccessToken(result.data?.token ?? "");
          localDataSource.setUserRole(result.data?.role ?? "");
          UserHelper.init(role: result.data!.role!);
          localDataSource.setIsDoctorVerified(result.data?.isVerified ?? true);
          localDataSource.setTotalUserAccounts(result.totalUserAccounts!);
        }

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserData>>> getUserAccounts() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getUserAccounts();

        return Right(result.data ?? []);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserData>> getSelectedUserAccounts(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getSelectedUserAccounts(id);

        return Right(result.data!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<SpecializationEntity>>> getSpecialisation(
      {int? start, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getSpecialisation(
            start: start, limit: limit);

        return Right(
            UserRepoConv.convSpecialisationModelToEntity(result.data ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> registration(
      RegistrationParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.registration(params);

        localDataSource.setAccessToken(result.token ?? "");

        return Right(result.message ?? "");
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UploadDocModel>> uploadDocument(File file) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.uploadDocument(file);

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MyProfileEntity>> getProfileDetails() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getProfileDetails();

        return Right(UserRepoConv.myProfileModelToEntity(result.data));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GenerateUsernameEntity>> generateUsernames() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.generateUsernames();

        return Right(GenerateUsernameEntity(userNames: result.userNames));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
