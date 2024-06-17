import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/doctor_datasource.dart';
import 'package:my_sutra/features/data/repositories/doctor_repo/doctor_repository_conv.dart';
import 'package:my_sutra/features/data/repositories/patient_repo/patient_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/booking_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/patient_appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/withdrawal_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/activate_deactivate_bank_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/checkout_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_fund_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_payout_contact.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_cancel_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_available_slots_for_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_reschedule_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_withdrawals_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/patient_appointments_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/update_time_slots_usecases.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../domain/entities/doctor_entities/get_doctor_appointment_entity.dart';
import '../../../domain/usecases/doctor_usecases/get_doctor_appointments_usecase.dart';
import '../../../domain/usecases/doctor_usecases/get_patient_usecase.dart';
import '../../../domain/usecases/doctor_usecases/get_time_slots_usecase.dart';
import '../../../domain/usecases/doctor_usecases/update_about_or_fees_usecase.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  final LocalDataSource localDataSource;
  final DoctorDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> updateTimeSlots(
      UpdateTimeSlotsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.updateTimeSlots(data.doctorTimeSlot.toJson);

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateAboutOrFess(
      UpdateAboutOrFeesParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.updateAboutOrFees({
          if (data.fees != null) 'fees': data.fees,
          if (data.about != null) 'about': data.about
        });

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PatientEntity>>> getPatients(
      GetPatientsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getPatients({
          'pagination': data.pagination,
          'limit': data.limit,
        });

        return Right(PatientRepoConv.patientModelToEntity(result.patients));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTimeSlotsResponseEntity>> getTimeSlots(
      GetTimeSlotsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getTimeSlots({
          'pagination': data.pagination,
          'limit': data.limit,
        });

        return Right(DoctorRepositoryConv.convertTimeSlotModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetDoctorAppointmentEntity>> getAppointments(
      GetDoctorAppointmentsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getAppointments({
          'date': data.date,
          'pagination': data.pagination,
          'limit': data.limit,
        });

        return Right(
            DoctorRepositoryConv.convertDoctorAppointmentModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> cancelAppointment(
      CancelAppointmentParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource
            .cancelAppointment({'appointmentId': params.appointmentId});

        return Right(result.message ?? 'Appointment Cancel Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> rescheduleAppointment(
      RescheduleAppointmentParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.rescheduleAppointment({
          'appointmentId': params.appointmentId,
          'date': params.date,
          'time': params.time
        });

        return Right(result.message ?? 'Appointment Reschedule Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<AvailableTimeSlotEntity>>> getAvailableSlots(
      GetAvailableSlotsForDoctorParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.getAvailableSlots({'date': params.date});

        return Right(
            DoctorRepositoryConv.convertAvailableSlotModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createPayoutContact(
      CreatePayoutContactParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.createPayoutContact({
          "name": params.name,
          "email": params.email,
          "contact": params.contact
        });

        return Right(result.message ?? 'Account Created');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> createFundAccount(
      CreateFundAccountParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.createFundAccount({
          "name": params.name,
          "ifsc": params.ifsc,
          "accountNumber": params.accountNumber
        });

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> createUpi(String upi) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.createUpi(upi);

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<BankAccountEntity>>> getAccounts(
      GeneralPagination params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource
            .getAccounts({'pagination': params.start, 'limit': params.limit});

        return Right(DoctorRepositoryConv.convertBankAccountModelToEntity(
            result.items ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> activateDeactivateBankAccount(
      ActivateDeactivateBankAccountParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.activateDeactivateBankAccount(
            {"fundAccountId": params.accountId, "active": params.activate});

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, WithdrawalEntity>> getWithdrawals(
      GetPayoutParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getWithdrawals({
          "earningType": params.earningType ?? 'WITHDRAWAL',
          "date": params.date,
          "pagination": params.pagination,
          "limit": params.limit
        });

        return Right(
            DoctorRepositoryConv.convertWithrawalModelToEntity(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings(
      GetPayoutParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getBookings({
          "earningType": params.earningType ?? 'BOOKING',
          "date": params.date,
          "pagination": params.pagination,
          "limit": params.limit
        });

        return Right(DoctorRepositoryConv.convertBookingModelToEntity(
            result.data ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> checkout(CheckoutParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.checkout({
          "fundAccountId": params.accountId,
          "mode": params.mode,
          "amount": params.amount
        });

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getProcessingAmount() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getProcessingAmount();

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<PatientAppointmentEntity>>>
      getPatientAppointments(GetPatientAppointmentsParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getPatientAppointments({
          "patientId": params.id,
          "pagination": params.pageNumber,
          "limit": params.limit
        });

        return Right(DoctorRepositoryConv.convertPatientAppontmentModel(
            result.data ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
