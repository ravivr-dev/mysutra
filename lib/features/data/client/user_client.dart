// import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_sutra/features/data/model/user_models/create_chat_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';
import 'package:my_sutra/features/data/model/user_models/general_model.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/data/model/user_models/user_accounts_model.dart';
import 'package:retrofit/http.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:retrofit/retrofit.dart';

import '../model/user_models/generate_username_model.dart';
import '../model/user_models/home_response_model.dart';
import '../model/user_models/my_profile_model.dart';
import '../model/user_models/video_room_response_model.dart';

part 'user_client.g.dart';

/// Use below command to generate
/// fvm flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class UserRestClient {
  factory UserRestClient(
    final Dio dio,
    final LocalDataSource localDataSource,
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.addRequestOptions(localDataSource);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          e.printErrorPath();
          return handler.next(e);
        },
      ),
    );
    return _UserRestClient(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }

  @POST(EndPoints.login)
  Future<GeneralModel> login(
    @Field("countryCode") String countryCode,
    @Field("phoneNumber") int phoneNumber,
  );

  @POST(EndPoints.verifyOtp)
  Future<OtpResponseUserModel> verifyOtp(@Field("otp") int otp);

  @GET(EndPoints.accounts)
  Future<UserAccountsModel> getUserAccounts();

  @POST(EndPoints.accounts)
  Future<OtpResponseUserModel> getSelectedUserAccounts(
      @Field("userId") String id);

  @GET(EndPoints.userSpecialization)
  Future<SpecializationModel> getSpecialisation(
    @Query("pagination") int? start,
    @Query("limit") int? limit,
  );

  @POST(EndPoints.userRegistration)
  Future<GeneralModel> registration(
    @Field("role") String role,
    @Field("profilePic") String? profilePic,
    @Field("fullName") String? fullName,
    @Field("countryCode") String? countryCode,
    @Field("phoneNumber") int? phoneNumber,
    @Field("email") String? email,
    @Field("specializationId") String? specializationId,
    @Field("registrationNumber") String? registrationNumber,
    @Field("age") String? age,
    @Field("totalExperience") int? experience,
    @Field("socialProfileUrls") List<String>? socialUrls,
    @Field("username") String? userName,
  );

  @POST(EndPoints.uploadFile)
  Future<UploadDocModel> uploadDocument(
    @Part() File file,
  );

  @GET(EndPoints.userProfile)
  Future<MyProfileResponseModel> getProfileDetails();

  @GET(EndPoints.generateUserName)
  Future<GenerateUsernameModel> generateUserNames(
      @Query('username') String username);

  @GET(EndPoints.userHome)
  Future<HomeResponseModel> getHomeData();

  @PATCH(EndPoints.changeEmail)
  Future<SuccessMessageModel> changeEmail(
    @Body() Map<String, dynamic> map,
  );

  @PATCH(EndPoints.verifyChangeEmail)
  Future<SuccessMessageModel> verifyChangeEmail(
    @Body() Map<String, dynamic> map,
  );

  @PATCH(EndPoints.changePhoneNumber)
  Future<SuccessMessageModel> changePhoneNumber(
    @Body() Map<String, dynamic> map,
  );

  @PATCH(EndPoints.verifyChangePhoneNumber)
  Future<SuccessMessageModel> verifyChangePhoneNumber(
    @Body() Map<String, dynamic> map,
  );

  @GET(EndPoints.userFollowing)
  Future<ResponseModel> getFollowings(@Queries() Map<String, dynamic> map);

  @POST(EndPoints.userMessage)
  Future<CreateChatModel> sendMessage(
    @Body() final Map<String, dynamic> data,
  );

  // @GET(EndPoints.userMessage)
  // Future<ChatModel> getMessages(
  //   @Queries() final Map<String, dynamic> queries,
  // );

  @PUT(EndPoints.clearMessage)
  Future<dynamic> clearMessage(@Field("appointmentId") String appointmentId);

  @POST(EndPoints.videoSdkRoom)
  Future<VideoRoomResponseModel> getVideoRoomId(
      @Body() Map<String, dynamic> map);
}
