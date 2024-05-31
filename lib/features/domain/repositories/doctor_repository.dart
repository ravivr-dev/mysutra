import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_fund_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_payout_contact.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_cancel_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_available_slots_for_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_reschedule_appointment_usecase.dart';
import '../entities/doctor_entities/get_doctor_appointment_entity.dart';
import '../usecases/doctor_usecases/get_doctor_appointments_usecase.dart';
import '../usecases/doctor_usecases/get_patient_usecase.dart';
import '../usecases/doctor_usecases/get_time_slots_usecase.dart';
import '../usecases/doctor_usecases/update_about_or_fees_usecase.dart';
import '../usecases/doctor_usecases/update_time_slots_usecases.dart';

abstract class DoctorRepository {
  Future<Either<Failure, dynamic>> updateTimeSlots(UpdateTimeSlotsParams data);

  Future<Either<Failure, dynamic>> updateAboutOrFess(
      UpdateAboutOrFeesParams data);

  Future<Either<Failure, List<PatientEntity>>> getPatients(
      GetPatientsParams data);

  Future<Either<Failure, GetTimeSlotsResponseEntity>> getTimeSlots(
      GetTimeSlotsParams data);

  Future<Either<Failure, GetDoctorAppointmentEntity>> getAppointments(
      GetDoctorAppointmentsParams data);

  Future<Either<Failure, String>> cancelAppointment(
      CancelAppointmentParams params);

  Future<Either<Failure, String>> rescheduleAppointment(
      RescheduleAppointmentParams params);

  Future<Either<Failure, List<AvailableTimeSlotEntity>>> getAvailableSlots(GetAvailableSlotsForDoctorParams params);

  Future<Either<Failure, String>> createPayoutContact(CreatePayoutContactParams params) ;

  Future<Either<Failure, dynamic>> createFundAccount(CreateFundAccountParams params) ;
}
