import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/file_manager.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/user_datasource.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/data/repositories/user_repo/user_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/generate_username_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/my_profile_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/video_room_response_entity.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_number_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/follow_user_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_video_room_id_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';

import '../../../domain/entities/patient_entities/follow_entity.dart';
import '../../../domain/entities/user_entities/user_data_entity.dart';
import '../../../domain/entities/user_entities/user_entity.dart';
import '../../../domain/usecases/user_usecases/download_pdf_usecase.dart';
import '../../../domain/usecases/user_usecases/get_following_usecase.dart';
import '../../model/patient_models/follow_model.dart';

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
  Future<Either<Failure, OtpResponseUserModel>> verifyOtp(int otp) async {
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
        localDataSource.setAccessToken(result.data!.token!);
        localDataSource.setIsAccountSelected(true);
        localDataSource.setUserRole(result.data?.role ?? "");

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
  Future<Either<Failure, GenerateUsernameEntity>> generateUsernames(
      String userName) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.generateUsernames(userName);

        return Right(GenerateUsernameEntity(
            userNames: result.userNames,
            userNameAvailable: result.userNameAvailable));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getHomeData() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getHomeData();
        UserHelper.init(role: result.userModel.role);
        localDataSource.setUserRole(result.userModel.role);

        if (result.userModel.profilePic != null) {
          localDataSource.setUserProfilePic(result.userModel.profilePic!);
        }

        return Right(UserRepoConv.userModelToEntity(result.userModel));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changeEmail(ChangeEmailParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.changeEmail({'email': params.email});
        return Right(result.message ?? 'Verify OTP to Change Email');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyChangeEmail(int otp) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.verifyChangeEmail({'otp': otp});
        return Right(result.message ?? 'Change Email Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changePhoneNumber(
      ChangePhoneNumberParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.changePhoneNumber({
          'countryCode': params.countryCode,
          'phoneNumber': params.newNumber
        });
        return Right(result.message ?? 'Verify OTP to Change Phone Number');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyChangePhoneNumber(int otp) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.verifyChangePhoneNumber({'otp': otp});
        return Right(result.message ?? 'Change Phone Number Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserDataEntity>>> getFollowings(
      GetFollowingParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getFollowing({
          'pagination': data.pagination,
          'limit': data.limit,
        });

        return Right(
            UserRepoConv.convertUserDataModelToEntity(result.userDataList));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, VideoRoomResponseEntity>> getVideoRoomId(
      GetVideoRoomIdUseCaseParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getVideoRoomId({
          'appointmentId': data.appointmentId,
        });

        return Right(UserRepoConv.videoRoomResponseModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FollowEntity>> followUser(
      FollowUserParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.followUser({
          'userId': data.userId,
        });

        return Right(UserRepoConv.followModelToEntity(
            FollowModel.fromJson(result['data'] ?? {})));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> downloadPdf(DownloadPdfParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.downloadPdf(data.url);
        final directory = await FileManager().getApplicationDirectory();
        final filePath = '${directory.path}/${data.url.split('/').last}';
        final file = File(filePath);

        file.writeAsBytes(result.response.data);

        return Right(file.path);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
