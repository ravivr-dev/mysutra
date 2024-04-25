import 'package:my_sutra/core/utils/constants.dart';

import '../patient_models/get_appointment_response_model.dart';

class GetDoctorAppointmentModel {
  final String? message;
  final int? totalAppointments;
  final int? completedAppointments;
  final int? pendingAppointments;
  final int? count;
  final List<AppointmentModel> list;

  GetDoctorAppointmentModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        totalAppointments = json[Constants.totalAppointments],
        completedAppointments = json[Constants.completedAppointments],
        pendingAppointments = json[Constants.pendingAppointments],
        count = json[Constants.count],
        list = (json[Constants.data] as List)
            .map((e) => AppointmentModel.fromJson(e))
            .toList();
}
