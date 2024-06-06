import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/generate_username_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_number_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_followers_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/update_device_token_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/update_profile_usecase.dart';

import '../entities/patient_entities/follow_entity.dart';
import '../entities/user_entities/my_profile_entity.dart';
import '../entities/user_entities/user_data_entity.dart';
import '../entities/user_entities/user_entity.dart';
import '../entities/user_entities/video_room_response_entity.dart';
import '../usecases/user_usecases/download_pdf_usecase.dart';
import '../usecases/user_usecases/follow_user_usecase.dart';
import '../usecases/user_usecases/get_following_usecase.dart';
import '../usecases/user_usecases/get_video_room_id_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(
      {required String countryCode, required String phoneNumber});

  Future<Either<Failure, OtpResponseUserModel>> verifyOtp(int otp);

  Future<Either<Failure, List<UserData>>> getUserAccounts();

  Future<Either<Failure, UserData>> getSelectedUserAccounts(String id);

  Future<Either<Failure, List<SpecializationEntity>>> getSpecialisation(
      {int? start, int? limit});

  Future<Either<Failure, String>> registration(RegistrationParams params);

  Future<Either<Failure, UploadDocModel>> uploadDocument(File file);

  Future<Either<Failure, MyProfileEntity>> getProfileDetails();

  Future<Either<Failure, GenerateUsernameEntity>> generateUsernames(
      String userName);

  Future<Either<Failure, UserEntity>> getHomeData();

  Future<Either<Failure, String>> changeEmail(ChangeEmailParams params);

  Future<Either<Failure, String>> verifyChangeEmail(int otp);

  Future<Either<Failure, String>> changePhoneNumber(
      ChangePhoneNumberParams params);

  Future<Either<Failure, String>> verifyChangePhoneNumber(int otp);

  Future<Either<Failure, List<UserDataEntity>>> getFollowings(
      GetFollowingParams data);

  Future<Either<Failure, VideoRoomResponseEntity>> getVideoRoomId(
      GetVideoRoomIdUseCaseParams data);

  Future<Either<Failure, FollowEntity>> followUser(FollowUserParams data);

  Future<Either<Failure, String>> downloadPdf(DownloadPdfParams data);

  Future<Either<Failure, List<UserDataEntity>>> getFollowers(
      GetFollowersParams params);

  Future<Either<Failure, dynamic>> updateDeviceToken(DeviceTokenParams params);

  Future<Either<Failure, dynamic>> logout();

  Future<Either<Failure, String>> updateProfile(UpdateProfileParams params);
}
