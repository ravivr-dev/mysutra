// ignore_for_file: body_might_complete_normally_catch_error

import 'package:dio/dio.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/user_client.dart';
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

abstract class UserDataSource {
  Future<AcademyCentersModel> getAcademyCentres({int? pageNumber, int? limit});

  Future<SuccessMessageModel> login(
      {
      required String countryCode,
      required String phoneNumber});

  Future<OtpResponseModel> sendOtp(
      {
      required String countryCode,
      required String phoneNumber,
      required String otp});

  Future<MyAcademyCenterModel> getMyAcademyCentres(
      {int? pageNumber, int? limit});

  Future<BatchesModel> getMyBatches({int? pageNumber, int? limit});

  Future<TrainingProgramModel> getTrainingProgram(String academyId);

  Future<SuccessMessageModel> checkIn();

  Future<SuccessMessageModel> checkOut();

  Future<SuccessMessageModel> logout();

  Future<UserProfileModel> getProfile();

  Future<SuccessMessageModel> changePhone(
      {required String countryCode, required int phoneNumber});

  Future<SuccessMessageModel> changePhoneOtp({required int otp});

  Future<SuccessMessageModel> changeEmail({required String email});

  Future<SuccessMessageModel> changeEmailOtp({required int otp});

  Future<BatchStudentsModel> getBatchStudents({int? pageNumber, int? limit});

  Future<SuccessMessageModel> markAttendance(
      {required String? date, required List<String>? studentIds});

  Future<CheckinStatusModel> getCheckinStatus({int? pageNumber, int? limit});
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
  Future<AcademyCentersModel> getAcademyCentres(
      {int? pageNumber, int? limit}) async {
    try {
      return await client
          .getAcademyCentres(pageNumber, limit)
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
  Future<SuccessMessageModel> login(
      {
      required String countryCode,
      required String phoneNumber}) async {
    try {
      return await client
          .login( countryCode, int.parse(phoneNumber))
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
  Future<OtpResponseModel> sendOtp(
      {
      required String countryCode,
      required String phoneNumber,
      required String otp}) async {
    try {
      return await client
          .sendOtp( countryCode, int.parse(phoneNumber), int.parse(otp))
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
  Future<MyAcademyCenterModel> getMyAcademyCentres(
      {int? pageNumber, int? limit}) async {
    try {
      return await client
          .getMyAcademyCentres(pageNumber, limit)
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
  Future<BatchesModel> getMyBatches({int? pageNumber, int? limit}) async {
    try {
      return await client.getMyBatches(pageNumber, limit).catchError((err) {
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
  Future<TrainingProgramModel> getTrainingProgram(String academyId) async {
    try {
      return await client.getTrainingProgram(academyId).catchError((err) {
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
  Future<SuccessMessageModel> checkIn() async {
    try {
      return await client.checkIn().catchError((err) {
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
  Future<SuccessMessageModel> checkOut() async {
    try {
      return await client.checkOut().catchError((err) {
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
  Future<SuccessMessageModel> logout() async {
    try {
      return await client.logout().catchError((err) {
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
  Future<UserProfileModel> getProfile() async {
    try {
      return await client.getProfile().catchError((err) {
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
  Future<SuccessMessageModel> changePhone(
      {required String countryCode, required int phoneNumber}) async {
    try {
      return await client
          .changePhone(countryCode, phoneNumber)
          .catchError((err) {
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
  Future<SuccessMessageModel> changePhoneOtp({required int otp}) async {
    try {
      return await client.changePhoneOtp(otp).catchError((err) {
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
  Future<SuccessMessageModel> changeEmail({required String email}) async {
    try {
      return await client.changeEmail(email).catchError((err) {
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
  Future<SuccessMessageModel> changeEmailOtp({required int otp}) async {
    try {
      return await client.changeEmailOtp(otp).catchError((err) {
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
  Future<BatchStudentsModel> getBatchStudents(
      {int? pageNumber, int? limit}) async {
    try {
      return await client.getBatchStudents(pageNumber, limit).catchError((err) {
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
  Future<SuccessMessageModel> markAttendance(
      {required String? date, required List<String>? studentIds}) async {
    try {
      return await client
          .markStudentAttendance(date, studentIds)
          .catchError((err) {
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
  Future<CheckinStatusModel> getCheckinStatus(
      {int? pageNumber, int? limit}) async {
    try {
      return await client.getCheckinStatus(pageNumber, limit).catchError((err) {
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
