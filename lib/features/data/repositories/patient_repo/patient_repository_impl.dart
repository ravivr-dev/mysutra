import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/patient_datasource.dart';
import 'package:my_sutra/features/data/model/patient_models/follow_model.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/data/repositories/patient_repo/patient_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/follow_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/follow_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

import '../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../domain/entities/patient_entities/schedule_appointment_response_entity.dart';
import '../../../domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_appointments_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_available_slots_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_doctor_details_usecase.dart';
import '../../../domain/usecases/patient_usecases/schedule_appointment_usecase.dart';

class PatientRepositoryImpl extends PatientRepository {
  final LocalDataSource localDataSource;
  final PatientDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PatientRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors(
      SearchDoctorParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.searchDoctors(data);

        return Right(
            PatientRepoConv.convSpecialisationModelToEntity(result.data ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FollowEntity>> followDoctor(
      FollowDoctorParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.followDoctor({
          'doctorId': data.doctorId,
        });

        return Right(PatientRepoConv.followModelToEntity(
            FollowModel.fromJson(result['data'] ?? {})));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<AvailableTimeSlotEntity>>> getAvailableSlots(
      GetAvailableSlotsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getAvailableSlots({
          'doctorId': data.doctorID,
          'date': data.date,
        });

        return Right(
            PatientRepoConv.availableTimeSlotModelToEntity(result.timeSlots));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> getDoctorDetails(
      GetDoctorDetailsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getDoctorDetails(data.doctorID);

        return Right(PatientRepoConv.doctorModelToEntity(
            DoctorDataModel.fromJson(result['data'])));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ScheduleAppointmentResponseEntity>>
      scheduleAppointment(ScheduleAppointmentParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.scheduleAppointment({
          'doctorId': data.doctorID,
          'date': data.date,
          'time': data.time,
          'patientDetails': {
            'fullName': data.patientName,
            'age': data.patientAge,
            'gender': data.patientGender,
            'countryCode': '+91',
            'phoneNumber': data.patientNumber,
            'email': data.patientEmail,
            'problem': data.patientProblem
          },
        });

        return Right(ScheduleAppointmentResponseEntity(
            message: result.message, token: result.token));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> confirmAppointment(
      ConfirmAppointmentParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.confirmAppointment(
          map: {
            'otp': data.otp,
          },
          token: 'Bearer ${data.token}',
        );
        if (result['token'] != null) {
          localDataSource.setAccessToken(result['token']);
        }

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(
      GetAppointmentsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getAppointments({
          'date': data.date,
          'pagination': data.pagination,
          'limit': data.limit,
        });

        return Right(PatientRepoConv.appointmentModelListToEntity(result.data));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
