import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/user_datasource.dart';
import 'package:my_sutra/features/data/repositories/user_repo/user_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/checkin_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
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
  Future<Either<Failure, List<AcademyCenter>>> getAcademyCentres(
      {int? pageNumber, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getAcademyCentres(
            pageNumber: pageNumber, limit: limit);

        return Right(
            UserRepositoryConv.convertAcademicCentersModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

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

  @override
  Future<Either<Failure, String>> sendOtp(
      {required String countryCode,
      required String phoneNumber,
      required String otp}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.sendOtp(
          countryCode: countryCode,
          phoneNumber: phoneNumber,
          otp: otp,
        );

        if (result.otpData != null) {
          localDataSource.setAccessToken(result.otpData!.accessToken!);
          localDataSource.setUserRole(result.otpData!.role!);
          // localDataSource.setCurrentAcademy(academy);
          localDataSource.setUserName(result.otpData!.name ?? "");
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
  Future<Either<Failure, List<AcademyCenter>>> getMyAcademyCentres(
      {int? pageNumber, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getMyAcademyCentres(
            pageNumber: pageNumber, limit: limit);

        return Right(
            UserRepositoryConv.convertMyAcademicCentersModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<BatchItem>>> getMyBatches(
      {int? pageNumber, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getMyBatches(
            pageNumber: pageNumber, limit: limit);

        return Right(UserRepositoryConv.convertBatchesModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TrainingProgram>>> getTrainingProgram(
      String academyId) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getTrainingProgram(academyId);

        return Right(UserRepositoryConv.convertTrainingModelToEntity(
            result.data?.coachingProgram));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> checkIn() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.checkIn();

        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> checkOut() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.checkOut();

        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getProfile() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getProfile();

        if (result.data != null) {
          localDataSource.setUserName(result.data!.name ?? "");
        }

        return Right(
            UserRepositoryConv.convertUserProfileModelToEntity(result.data!));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changePhone(
      {required String countryCode, required int phoneNumber}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.changePhone(
            countryCode: countryCode, phoneNumber: phoneNumber);

        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changePhoneOtp({required int otp}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.changePhoneOtp(otp: otp);

        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changeEmail({required String email}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.changeEmail(email: email);

        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changeEmailOtp({required int otp}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.changeEmailOtp(otp: otp);

        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserProfileEntity>>> getBatchStudents(
      {int? pageNumber, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getBatchStudents(
            pageNumber: pageNumber, limit: limit);

        return Right(
            UserRepositoryConv.convertBatchStudentsModelToEntity(result.data!));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> markAttendance(
      String? date, List<String>? studentIds) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.markAttendance(
            date: date, studentIds: studentIds);
        return Right(result.message!);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CheckinEntity>> getCheckinStatus(
      {int? pageNumber, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getCheckinStatus(
            pageNumber: pageNumber, limit: limit);
        return Right(UserRepositoryConv.connvertCheckingData(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
