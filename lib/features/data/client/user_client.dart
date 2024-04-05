import 'package:dio/dio.dart';
import 'package:my_sutra/features/data/model/user_models/general_model.dart';
import 'package:retrofit/http.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';

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

  @POST(ENDPOINT_LOGIN)
  Future<GeneralModel> login(
    @Field("countryCode") String countryCode,
    @Field("phoneNumber") int phoneNumber,
  );
}
