// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/user_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';
import 'package:my_sutra/features/data/model/user_models/follow_user_model.dart';
import 'package:my_sutra/features/data/model/user_models/general_model.dart';
import 'package:my_sutra/features/data/model/user_models/home_response_model.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/data/model/user_models/user_accounts_model.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:retrofit/dio.dart';

import '../../model/user_models/generate_username_model.dart';
import '../../model/user_models/my_profile_model.dart';
import '../../model/user_models/video_room_response_model.dart';

abstract class UserDataSource {
  Future<GeneralModel> login(
      {required String countryCode, required String phoneNumber});

  Future<OtpResponseUserModel> verifyOtp(int otp);

  Future<UserAccountsModel> getUserAccounts();

  Future<OtpResponseUserModel> getSelectedUserAccounts(String id);

  Future<SpecializationModel> getSpecialisation({int? start, int? limit});

  Future<GeneralModel> registration(RegistrationParams params);

  Future<UploadDocModel> uploadDocument(io.File file);

  Future<MyProfileResponseModel> getProfileDetails();

  Future<GenerateUsernameModel> generateUsernames(String userName);

  Future<HomeResponseModel> getHomeData();

  Future<SuccessMessageModel> changePhoneNumber(Map<String, dynamic> map);

  Future<SuccessMessageModel> verifyChangePhoneNumber(Map<String, dynamic> map);

  Future<SuccessMessageModel> changeEmail(Map<String, dynamic> map);

  Future<SuccessMessageModel> verifyChangeEmail(Map<String, dynamic> map);

  Future<ResponseModel> getFollowing(Map<String, dynamic> map);

  Future<ResponseModel> getFollowers(Map<String, dynamic> map);

  Future<VideoRoomResponseModel> getVideoRoomId(Map<String, dynamic> data);

  Future<FollowUserModel> followUser(Map<String, dynamic> data);

  Future<HttpResponse> downloadPdf(String url);
}

class UserDataSourceImpl extends UserDataSource {
  final UserRestClient client;
  final LocalDataSource localDataSource;

  UserDataSourceImpl({required this.client, required this.localDataSource});

  void _processDio(err) {
    if (err is DioException) {
      throw ServerException(
        message: err.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } else {
      throw ServerException(message: Constants.errorUnknown);
    }
  }

  @override
  Future<GeneralModel> login(
      {required String countryCode, required String phoneNumber}) async {
    try {
      return await client
          .login(countryCode, int.parse(phoneNumber))
          .catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<OtpResponseUserModel> verifyOtp(int otp) async {
    try {
      return await client.verifyOtp(otp).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UserAccountsModel> getUserAccounts() async {
    try {
      return await client.getUserAccounts().catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<OtpResponseUserModel> getSelectedUserAccounts(String id) async {
    try {
      return await client.getSelectedUserAccounts(id).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SpecializationModel> getSpecialisation(
      {int? start, int? limit}) async {
    try {
      return await client.getSpecialisation(start, limit).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GeneralModel> registration(RegistrationParams params) async {
    try {
      return await client
          .registration(
        params.role,
        params.profilePic,
        params.fullName,
        params.countryCode,
        params.phoneNumber,
        params.email,
        params.specializationId,
        params.registrationNumber,
        params.age,
        params.experience,
        params.socialUrls,
        params.userName,
      )
          .catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UploadDocModel> uploadDocument(io.File file) async {
    try {
      return await client.uploadDocument(file).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<MyProfileResponseModel> getProfileDetails() async {
    try {
      return await client.getProfileDetails().catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GenerateUsernameModel> generateUsernames(String userName) async {
    try {
      return await client.generateUserNames(userName).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<HomeResponseModel> getHomeData() async {
    try {
      return await client.getHomeData().catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> changeEmail(Map<String, dynamic> map) async {
    try {
      return await client.changeEmail(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> verifyChangeEmail(
      Map<String, dynamic> map) async {
    try {
      return await client.verifyChangeEmail(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> changePhoneNumber(
      Map<String, dynamic> map) async {
    try {
      return await client.changePhoneNumber(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> verifyChangePhoneNumber(
      Map<String, dynamic> map) async {
    try {
      return await client.verifyChangePhoneNumber(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> getFollowing(Map<String, dynamic> map) async {
    try {
      return await client.getFollowings(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<VideoRoomResponseModel> getVideoRoomId(
      Map<String, dynamic> data) async {
    try {
      return await client.getVideoRoomId(data).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<FollowUserModel> followUser(Map<String, dynamic> data) async {
    try {
      return await client.followUser(data).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<HttpResponse> downloadPdf(String url) async {
    try {
      return await client.downloadPdf(url).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
        message: e.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> getFollowers(Map<String, dynamic> map) async {
    try {
      return await client.getFollowers(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              localDataSource: localDataSource, validateAuthentication: true));
    } on Exception {
      rethrow;
    }
  }
}
