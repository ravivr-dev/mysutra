import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/patient_datasource.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/data/repositories/patient_repo/patient_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_history_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_order_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_history_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_order_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/rate_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

import '../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../domain/entities/patient_entities/schedule_appointment_response_entity.dart';
import '../../../domain/usecases/patient_usecases/cancel_appointment_usecase.dart';
import '../../../domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_appointments_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_available_slots_for_patient_usecase.dart';
import '../../../domain/usecases/patient_usecases/get_doctor_details_usecase.dart';
import '../../../domain/usecases/patient_usecases/past_appointments_usecase.dart';
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
  Future<Either<Failure, List<AvailableTimeSlotEntity>>> getAvailableSlots(
      GetAvailableSlotsForPatientParams data) async {
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
          if (data.doctorID != null) 'doctorId': data.doctorID,
          'date': data.date,
          'time': data.time,
          'fees': data.fees,
          if (data.appointmentId != null) 'appointmentId': data.appointmentId,
          if (data.patientNumber != null)
            'patientDetails': {
              // 'username': data.patientName,
              'age': data.patientAge,
              'gender': data.patientGender,
              'countryCode': '+91',
              'phoneNumber': data.patientNumber,
              'email': data.patientEmail,
              // 'problem': data.patientProblem
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
  Future<Either<Failure, String>> confirmAppointment(
      ConfirmAppointmentParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.confirmAppointment(
          map: {
            'otp': data.otp,
          },
          token: 'Bearer ${data.token}',
        );
        if (result.token != null) {
          localDataSource.setAccessToken(result.token!);
        }

        return Right(result.data?.id ?? '');
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

  @override
  Future<Either<Failure, dynamic>> cancelAppointment(
      CancelAppointmentParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource
            .cancelAppointment({'appointmentId': data.appointmentId});

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> pastAppointments(
      PastAppointmentsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.pastAppointments({
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

  @override
  Future<Either<Failure, String>> getRasorpayKey() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getRasorpayKey();

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentOrderEntity>> paymentOrder(
      PaymentOrderParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.paymentOrder(
            {"appointmentId": params.id, "amount": params.amount});

        return Right(PatientRepoConv.paymnetOrderModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PaymentHistoryEntity>>> paymentHistory(
      PaginationParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.paymentHistory(
            {"pagination": params.pagination, "limit": params.limit});

        return Right(
            PatientRepoConv.paymentHistoryModelToEntity(result.data ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> rateAppointment(
      RateAppointmentParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.rateAppointment({
          "appointmentId": params.appointmentId,
          "doctorId": params.doctorId,
          "ratings": params.rating
        });
        return Right(result.message ?? 'Rate Appointment Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
