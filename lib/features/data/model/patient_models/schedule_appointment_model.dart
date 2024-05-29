class ScheduleAppointmentModel {
  String? message;
  String? token;
  ScheduleAppointmentData? data;

  ScheduleAppointmentModel({this.message, this.token, this.data});

  ScheduleAppointmentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? ScheduleAppointmentData.fromJson(json['data']) : null;
  }
}

class ScheduleAppointmentData {
  String? doctorId;
  String? userId;
  String? date;
  String? time;
  int? timeInMinutes;
  int? duration;
  int? fees;
  int? tax;
  int? totalAmount;
  PatientDetails? patientDetails;
  String? status;
  List<Null>? prescriptions;
  // Null? videoSdkRoomId;
  // Null? razorpayOrderId;
  // Null? razorpayPaymentId;
  // Null? paymentStatus;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  ScheduleAppointmentData(
      {this.doctorId,
      this.userId,
      this.date,
      this.time,
      this.timeInMinutes,
      this.duration,
      this.fees,
      this.tax,
      this.totalAmount,
      this.patientDetails,
      this.status,
      this.prescriptions,
      // this.videoSdkRoomId,
      // this.razorpayOrderId,
      // this.razorpayPaymentId,
      // this.paymentStatus,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.token});

  ScheduleAppointmentData.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    userId = json['userId'];
    date = json['date'];
    time = json['time'];
    timeInMinutes = json['timeInMinutes'];
    duration = json['duration'];
    fees = json['fees'];
    tax = json['tax'];
    totalAmount = json['totalAmount'];
    patientDetails = json['patientDetails'] != null
        ? PatientDetails.fromJson(json['patientDetails'])
        : null;
    status = json['status'];
    // if (json['prescriptions'] != null) {
    //   prescriptions = <Null>[];
    //   json['prescriptions'].forEach((v) {
    //     prescriptions!.add(Null.fromJson(v));
    //   });
    // }
    // videoSdkRoomId = json['videoSdkRoomId'];
    // razorpayOrderId = json['razorpayOrderId'];
    // razorpayPaymentId = json['razorpayPaymentId'];
    // paymentStatus = json['paymentStatus'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    token = json['token'];
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
