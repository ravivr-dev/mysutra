import 'package:dio/dio.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:retrofit/http.dart';
import '../../../core/utils/constants.dart';
import '../datasource/local_datasource/local_datasource.dart';

part 'doctor_client.g.dart';

@RestApi()
abstract class DoctorClient {
  factory DoctorClient(
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
    return _DoctorClient(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }

  @POST(EndPoints.timeSlots)
  Future<dynamic> updateTimeSlots(@Body() Map<String, dynamic> map);

  @PUT(EndPoints.profile)
  Future<dynamic> updateAboutOrFees(@Body() Map<String, dynamic> map);
}
