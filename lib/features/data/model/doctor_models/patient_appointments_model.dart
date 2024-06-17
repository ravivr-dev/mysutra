class PatientAppointmentsModel {
  String? message;
  int? count;
  PatientDetails? patientDetails;
  List<Appointment>? data;

  PatientAppointmentsModel(
      {this.message, this.count, this.patientDetails, this.data});

  PatientAppointmentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    patientDetails = json['patientDetails'] != null
        ? PatientDetails.fromJson(json['patientDetails'])
        : null;
    if (json['data'] != null) {
      data = <Appointment>[];
      json['data'].forEach((v) {
        data!.add(Appointment.fromJson(v));
      });
    }
  }
}

class PatientDetails {
  String? username;
  String? profilePic;
  String? countryCode;
  int? phoneNumber;
  String? date;
  String? time;
  int? timeInMinutes;

  PatientDetails(
      {this.username,
      this.profilePic,
      this.countryCode,
      this.phoneNumber,
      this.date,
      this.time,
      this.timeInMinutes});

  PatientDetails.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    profilePic = json['profilePic'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    date = json['date'];
    time = json['time'];
    timeInMinutes = json['timeInMinutes'];
  }
}

class Appointment {
  String? id;
  String? date;

  Appointment({
    this.id,
    this.date,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    date = json['date'];
  }
}
