class ScheduleAppointmentResponseModel {
  final String message;
  final String token;

  ScheduleAppointmentResponseModel({
    required this.message,
    required this.token,
  });

  ScheduleAppointmentResponseModel.fromJson(Map<String, dynamic> map)
      : message = map['message'],
        token = map['token'];
}
