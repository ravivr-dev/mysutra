import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/doctor_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/core/extension/dio_error.dart';

abstract class DoctorDataSource {
  Future updateTimeSlots(Map<String, dynamic> map);

  Future updateAboutOrFees(Map<String, dynamic> map);
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
}
