import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/download.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/doctor_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_bank_accounts_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_bookings_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_doctor_appointment_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_withdrawal_model.dart';
import 'package:my_sutra/features/data/model/patient_models/available_time_slot.dart';
import 'package:my_sutra/features/data/model/patient_models/get_patient_response_model.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';

import '../../model/doctor_models/get_time_slots_response_model.dart';

abstract class DoctorDataSource {
  Future updateTimeSlots(Map<String, dynamic> map);

  Future updateAboutOrFees(Map<String, dynamic> map);

  Future<GetPatientResponseModel> getPatients(Map<String, dynamic> map);

  Future<GetTimeSlotsResponseModel> getTimeSlots(Map<String, dynamic> map);

  Future<GetDoctorAppointmentModel> getAppointments(Map<String, dynamic> map);

  Future<SuccessMessageModel> rescheduleAppointment(Map<String, dynamic> map);

  Future<SuccessMessageModel> cancelAppointment(Map<String, dynamic> map);

  Future<AvailableTimeSlotResponse> getAvailableSlots(Map<String, dynamic> map);

  Future<SuccessMessageModel> createPayoutContact(Map<String, dynamic> map);

  Future<dynamic> createFundAccount(Map<String, String> map);

  Future<dynamic> createUpi(String upi);

  Future<GetBankAccountsModel> getAccounts();

  Future<dynamic> activateDeactivateBankAccount(Map<String, Object> map);

  Future<GetWithdrawalModel> getWithdrawals(Map<String, Object> map);

  Future<GetBookingsModel> getBookings(Map<String, Object> map);

  Future<dynamic> checkout(Map<String, Object> map);
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
  Future<GetDoctorAppointmentModel> getAppointments(
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
  Future<SuccessMessageModel> cancelAppointment(
      Map<String, dynamic> map) async {
    try {
      return await client.cancelAppointment(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> rescheduleAppointment(
      Map<String, dynamic> map) async {
    try {
      return await client.rescheduleAppointment(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
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
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<SuccessMessageModel> createPayoutContact(
      Map<String, dynamic> map) async {
    try {
      return await client.createPayoutContact(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<dynamic> createFundAccount(Map<String, String> map) async {
    try {
      return await client.createFundAccount(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<dynamic> createUpi(String upi) async {
    try {
      return await client.createUpi(upi).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GetBankAccountsModel> getAccounts() async {
    try {
      return await client.getFundAccounts().catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<dynamic> activateDeactivateBankAccount(Map<String, Object> map) async {
    try {
      return await client.activateDeactivateBankAccount(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GetWithdrawalModel> getWithdrawals(Map<String, Object> map) async {
    try {
      return await client.getWithdrawals(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<GetBookingsModel> getBookings(Map<String, Object> map) async {
    try {
      return await client.getBookings(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<dynamic> checkout(Map<String, Object> map) async {
    try {
      return await client.checkout(map).catchError((err) {
        _processDio(err);
      });
    } on DioException catch (e) {
      throw ServerException(
          message: e.getErrorFromDio(
              validateAuthentication: true, localDataSource: localDataSource));
    } on Exception {
      rethrow;
    }
  }
}
