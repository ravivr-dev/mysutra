import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/follow_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

import '../entities/patient_entities/appointment_entity.dart';
import '../entities/patient_entities/available_time_slot_entity.dart';
import '../entities/patient_entities/follow_entity.dart';
import '../entities/patient_entities/schedule_appointment_response_entity.dart';
import '../usecases/patient_usecases/confirm_appointment_usecase.dart';
import '../usecases/patient_usecases/get_appointments_usecase.dart';
import '../usecases/patient_usecases/get_available_slots_for_patient_usecase.dart';
import '../usecases/patient_usecases/get_doctor_details_usecase.dart';
import '../usecases/patient_usecases/schedule_appointment_usecase.dart';

abstract class PatientRepository {
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors(
      SearchDoctorParams data);

  Future<Either<Failure, FollowEntity>> followDoctor(FollowDoctorParams data);

  Future<Either<Failure, List<AvailableTimeSlotEntity>>> getAvailableSlots(
      GetAvailableSlotsForPatientParams data);

  Future<Either<Failure, DoctorEntity>> getDoctorDetails(
      GetDoctorDetailsParams data);

  Future<Either<Failure, ScheduleAppointmentResponseEntity>>
      scheduleAppointment(ScheduleAppointmentParams data);

  Future<Either<Failure, dynamic>> confirmAppointment(
      ConfirmAppointmentParams data);

  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(GetAppointmentsParams data);
}
