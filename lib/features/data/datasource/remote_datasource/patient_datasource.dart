import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/patient_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';
import 'package:my_sutra/core/extension/dio_error.dart';


abstract class PatientDataSource {
  Future<SearchDoctorModel> searchDoctors(SearchDoctorParams data);

  Future<Map<String, dynamic>> followDoctor(Map<String, dynamic> data);
}

class PatientDataSourceImpl extends PatientDataSource {
  final PatientRestClient client;
  final LocalDataSource localDataSource;

  PatientDataSourceImpl({required this.client, required this.localDataSource});


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
  Future<SearchDoctorModel> searchDoctors(SearchDoctorParams data) async {
    try {
      return await client
          .searchDoctors(data.search, data.experience,data.start, data.limit, data.reviews, data.specializationId)
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
  Future<Map<String, dynamic>> followDoctor(Map<String, dynamic> data) async {
    try {
      return await client.followDoctor(data).catchError((err) {
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