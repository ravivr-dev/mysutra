// ignore_for_file: body_might_complete_normally_catch_error

import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/user_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/user_models/general_model.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/data/model/user_models/user_accounts_model.dart';

abstract class UserDataSource {
  Future<GeneralModel> login(
      {required String countryCode, required String phoneNumber});

  Future<UserModel> verifyOtp(int otp);

  Future<UserAccountsModel> getUserAccounts();

  Future<UserModel> getSelectedUserAccounts(String id);

  Future<SpecializationModel> getSpecialisation({int? start, int? limit});
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
  Future<UserModel> verifyOtp(int otp) async {
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
  Future<UserModel> getSelectedUserAccounts(String id) async {
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
  Future<SpecializationModel> getSpecialisation({int? start, int? limit}) async {
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
}
