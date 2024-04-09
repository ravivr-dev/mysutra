// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _UserRestClient implements UserRestClient {
  _UserRestClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GeneralModel> login(
    String countryCode,
    int phoneNumber,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GeneralModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GeneralModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserModel> verifyOtp(int otp) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'otp': otp};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/verify-otp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserAccountsModel> getUserAccounts() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserAccountsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserAccountsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserModel> getSelectedUserAccounts(String id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'userId': id};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SpecializationModel> getSpecialisation(
    int? start,
    int? limit,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pagination': start,
      r'limit': limit,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SpecializationModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/specialization',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SpecializationModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GeneralModel> registration(
    String role,
    String? profilePic,
    String? fullName,
    String? countryCode,
    int? phoneNumber,
    String? email,
    String? specializationId,
    String? registrationNumber,
    int? age,
    int? experience,
    List<String>? socialUrls,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'role': role,
      'profilePic': profilePic,
      'fullName': fullName,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'email': email,
      'specializationId': specializationId,
      'registrationNumber': registrationNumber,
      'age': age,
      'totalExperience': experience,
      'socialProfileUrls': socialUrls,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GeneralModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/registration',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GeneralModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
