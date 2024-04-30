import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
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
}
