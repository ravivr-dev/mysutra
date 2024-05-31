import 'package:my_sutra/features/domain/entities/patient_entities/payment_history_entity.dart';

class PaymentHistoryModel {
  String? message;
  int? count;
  List<PaymentHistory>? data;

  PaymentHistoryModel({this.message, this.count, this.data});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <PaymentHistory>[];
      json['data'].forEach((v) {
        data!.add(PaymentHistory.fromJson(v));
      });
    }
  }

  map(PaymentHistoryEntity Function(dynamic e) param0) {}
}

class PaymentHistory {
  String? id;
  DoctorDetail? doctor;
  Specialization? specialization;
  String? date;
  String? time;
  int? timeInMinutes;
  int? duration;
  int? totalAmount;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  String? paymentStatus;

  PaymentHistory(
      {this.id,
      this.doctor,
      this.specialization,
      this.date,
      this.time,
      this.timeInMinutes,
      this.duration,
      this.totalAmount,
      this.razorpayOrderId,
      this.razorpayPaymentId,
      this.paymentStatus});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    doctor = json['doctorId'] != null
        ? DoctorDetail.fromJson(json['doctorId'])
        : null;
    specialization = json['specializationId'] != null
        ? Specialization.fromJson(json['specializationId'])
        : null;
    date = json['date'];
    time = json['time'];
    timeInMinutes = json['timeInMinutes'];
    duration = json['duration'];
    totalAmount = json['totalAmount'];
    razorpayOrderId = json['razorpayOrderId'];
    razorpayPaymentId = json['razorpayPaymentId'];
    paymentStatus = json['paymentStatus'];
  }
}

class DoctorDetail {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  String? specializationId;
  bool? isVerified;

  DoctorDetail(
      {this.id,
      this.role,
      this.profilePic,
      this.fullName,
      this.username,
      this.specializationId,
      this.isVerified});

  DoctorDetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    username = json['username'];
    specializationId = json['specializationId'];
    isVerified = json['isVerified'];
  }
}

class Specialization {
  String? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }
}
