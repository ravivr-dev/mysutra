import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';

class GetDoctorAppointmentEntity {
  final String? message;
  final int totalAppointments;
  final int completedAppointments;
  final int pendingAppointments;
  final int? count;
  final List<AppointmentEntity> list;

  GetDoctorAppointmentEntity({
    required this.message,
    required this.totalAppointments,
    required this.completedAppointments,
    required this.pendingAppointments,
    required this.count,
    required this.list,
  });
}
