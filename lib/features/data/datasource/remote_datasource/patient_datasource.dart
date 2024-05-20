import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/patient_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';
import 'package:my_sutra/core/extension/dio_error.dart';

import '../../model/patient_models/available_time_slot.dart';
import '../../model/patient_models/get_appointment_response_model.dart';
import '../../model/patient_models/schedule_appointment_response_model.dart';

abstract class PatientDataSource {
  Future<SearchDoctorModel> searchDoctors(SearchDoctorParams data);

  Future<AvailableTimeSlotResponse> getAvailableSlots(Map<String, dynamic> map);

  Future getDoctorDetails(String doctorId);

  Future<ScheduleAppointmentResponseModel> scheduleAppointment(
      Map<String, dynamic> map);

  Future confirmAppointment(
      {required Map<String, dynamic> map, required String token});

  Future<GetAppointmentResponseModel> getAppointments(Map<String, dynamic> map);

  Future<dynamic> cancelAppointment(Map<String, dynamic> map);
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
          .searchDoctors(data.search, data.experience, data.start, data.limit,
              data.reviews, data.specializationId)
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
  Future<AvailableTimeSlotResponse> getAvailableSlots(
      Map<String, dynamic> map) async {
    try {
      return await client.getAvailableSlots(map).catchError((err) {
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
  Future getDoctorDetails(String doctorId) async {
    try {
      return await client.getDoctorDetails(doctorId).catchError((err) {
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
  Future<ScheduleAppointmentResponseModel> scheduleAppointment(
      Map<String, dynamic> map) async {
    try {
      return await client.scheduleAppointment(map).catchError((err) {
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
  Future confirmAppointment(
      {required Map<String, dynamic> map, required String token}) async {
    try {
      return await client.confirmAppointment(map, token).catchError((err) {
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
  Future<GetAppointmentResponseModel> getAppointments(
      Map<String, dynamic> map) async {
    try {
      return await client.getAppointments(map).catchError((err) {
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
  Future<dynamic> cancelAppointment(Map<String, dynamic> map) async {
    try {
      return await client.cancelAppointment(map).catchError((err) {
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
