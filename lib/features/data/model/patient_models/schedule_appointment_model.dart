class ScheduleAppointmentModel {
  String? message;
  String? token;
  ScheduleAppointmentData? data;

  ScheduleAppointmentModel({this.message, this.token, this.data});

  ScheduleAppointmentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null
        ? ScheduleAppointmentData.fromJson(json['data'])
        : null;
  }
}

class ScheduleAppointmentData {
  int? amount;
  int? amountDue;
  int? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  Notes? notes;
  String? receipt;
  String? status;

  ScheduleAppointmentData(
      {this.amount,
      this.amountDue,
      this.amountPaid,
      this.attempts,
      this.createdAt,
      this.currency,
      this.entity,
      this.id,
      this.notes,
      this.receipt,
      this.status});

  ScheduleAppointmentData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountDue = json['amount_due'];
    amountPaid = json['amount_paid'];
    attempts = json['attempts'];
    createdAt = json['created_at'];
    currency = json['currency'];
    entity = json['entity'];
    id = json['id'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
    receipt = json['receipt'];
    status = json['status'];
  }
}

class Notes {
  String? appointmentUUID;
  String? date;
  String? doctorId;
  int? duration;
  int? fees;
  PatientDetails? patientDetails;
  int? tax;
  String? time;
  int? timeInMinutes;
  int? totalAmount;
  String? userId;

  Notes(
      {this.appointmentUUID,
      this.date,
      this.doctorId,
      this.duration,
      this.fees,
      this.patientDetails,
      this.tax,
      this.time,
      this.timeInMinutes,
      this.totalAmount,
      this.userId});

  Notes.fromJson(Map<String, dynamic> json) {
    appointmentUUID = json['appointmentUUID'];
    date = json['date'];
    doctorId = json['doctorId'];
    duration = json['duration'];
    fees = json['fees'];
    patientDetails = json['patientDetails'] != null
        ? PatientDetails.fromJson(json['patientDetails'])
        : null;
    tax = json['tax'];
    time = json['time'];
    timeInMinutes = json['timeInMinutes'];
    totalAmount = json['totalAmount'];
    userId = json['userId'];
  }
}

class PatientDetails {
  String? age;
  String? gender;
  String? countryCode;
  int? phoneNumber;
  String? email;
  String? username;

  PatientDetails(
      {this.age,
      this.gender,
      this.countryCode,
      this.phoneNumber,
      this.email,
      this.username});

  PatientDetails.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    gender = json['gender'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    username = json['username'];
  }
}
