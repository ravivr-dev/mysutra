import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/doctor_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/features/data/model/patient_models/get_patient_response_model.dart';

import '../../model/doctor_models/get_time_slots_response_model.dart';
import '../../model/user_models/home_response_model.dart';

abstract class DoctorDataSource {
  Future updateTimeSlots(Map<String, dynamic> map);

  Future updateAboutOrFees(Map<String, dynamic> map);

  Future<GetPatientResponseModel> getPatients(Map<String, dynamic> map);

  Future<GetTimeSlotsResponseModel> getTimeSlots(Map<String, dynamic> map);

  Future<HomeResponseModel> getUserDetails();
}

class DoctorDataSourceImpl extends DoctorDataSource {
  final DoctorClient client;
  final LocalDataSource localDataSource;

  DoctorDataSourceImpl({required this.client, required this.localDataSource});

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
  Future updateTimeSlots(Map<String, dynamic> map) async {
    try {
      return await client.updateTimeSlots(map).catchError((err) {
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
  Future updateAboutOrFees(Map<String, dynamic> map) async {
    try {
      return await client.updateAboutOrFees(map).catchError((err) {
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
  Future<GetPatientResponseModel> getPatients(Map<String, dynamic> map) async {
    try {
      return await client.getPatients(map).catchError((err) {
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
  Future<GetTimeSlotsResponseModel> getTimeSlots(
      Map<String, dynamic> map) async {
    try {
      return await client.getTimeSlots(map).catchError((err) {
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
  Future<HomeResponseModel> getUserDetails() async {
    try {
      return await client.getUserDetails().catchError((err) {
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
