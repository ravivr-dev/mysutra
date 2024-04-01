import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';
import 'package:my_sutra/features/data/model/user_models/academy_centers_model.dart';
import 'package:my_sutra/features/data/model/user_models/batch_students_model.dart';
import 'package:my_sutra/features/data/model/user_models/batches_model.dart';
import 'package:my_sutra/features/data/model/user_models/chekin_status_model.dart';
import 'package:my_sutra/features/data/model/user_models/my_academy_center_model.dart';
import 'package:my_sutra/features/data/model/user_models/otp_response_model.dart';
import 'package:my_sutra/features/data/model/user_models/training_program_model.dart';
import 'package:my_sutra/features/data/model/user_models/user_profile_model.dart';

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

  @GET(ENDPOINT_USER_PROFILE)
  Future<UserProfileModel> getProfile();

  @GET(ENDPOINT_ACADEMY_CENTER)
  Future<AcademyCentersModel> getAcademyCentres(
    @Query("pagination") int? pageNumber,
    @Query("limit") int? limit,
  );

  @POST(ENDPOINT_LOGIN)
  Future<SuccessMessageModel> login(
    @Field("academyCenterId") String academy,
    @Field("countryCode") String countryCode,
    @Field("phoneNumber") int phoneNumber,
  );

  @POST(ENDPOINT_LOGOUT)
  Future<SuccessMessageModel> logout();

  @POST(ENDPOINT_VERIFY_OTP)
  Future<OtpResponseModel> sendOtp(
    @Field("academyCenterId") String academy,
    @Field("countryCode") String countryCode,
    @Field("phoneNumber") int phoneNumber,
    @Field("otp") int otp,
  );

  @GET(ENDPOINT_MY_ACADEMY_CENTER)
  Future<MyAcademyCenterModel> getMyAcademyCentres(
    @Query("pagination") int? pageNumber,
    @Query("limit") int? limit,
  );

  @GET(ENDPOINT_BATCHES)
  Future<BatchesModel> getMyBatches(
    @Query("pagination") int? pageNumber,
    @Query("limit") int? limit,
  );

  @GET("$ENDPOINT_MY_ACADEMY_CENTER/{academyCenterId}")
  Future<TrainingProgramModel> getTrainingProgram(
      @Path("academyCenterId") String academyCenterId);

  @POST(ENDPOINT_CHECK_IN)
  Future<SuccessMessageModel> checkIn();

  @POST(ENDPOINT_CHECK_OUT)
  Future<SuccessMessageModel> checkOut();

  @PATCH(ENDPOINT_CHANGE_PHONE_NUMBER)
  Future<SuccessMessageModel> changePhone(
    @Field("countryCode") String countryCode,
    @Field("phoneNumber") int phoneNumber,
  );

  @PATCH(ENDPOINT_CHANGE_PHONE_NUMBER_VERIFY_OTP)
  Future<SuccessMessageModel> changePhoneOtp(
    @Field("otp") int otp,
  );

  @PATCH(ENDPOINT_CHANGE_EMAIL)
  Future<SuccessMessageModel> changeEmail(
    @Field("email") String email,
  );

  @PATCH(ENDPOINT_CHANGE_EMAIL_VERIFY_OTP)
  Future<SuccessMessageModel> changeEmailOtp(
    @Field("otp") int otp,
  );

  @GET(ENDPOINT_BATCH_STUDENTS)
  Future<BatchStudentsModel> getBatchStudents(
    @Query("pagination") int? pageNumber,
    @Query("limit") int? limit,
  );

  @POST(ENDPOINT_MARK_ATTENDANCE)
  Future<SuccessMessageModel> markStudentAttendance(
    @Field("date") String? date,
    @Field("studentIds") List<String>? studentIds,
  );

  @GET(ENDPOINT_CHECK_IN)
  Future<CheckinStatusModel> getCheckinStatus(
    @Query("pagination") int? pageNumber,
    @Query("limit") int? limit,
  );
}
