class GetPastAppointmentResponseModel {
  String? message;
  int? count;
  List<PastAppointmentResponseModel>? data;

  GetPastAppointmentResponseModel({this.message, this.count, this.data});

  GetPastAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <PastAppointmentResponseModel>[];
      json['data'].forEach((v) {
        data!.add(PastAppointmentResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PastAppointmentResponseModel {
  String? id;
  String? doctorId;
  String? userId;
  String? profilePic;
  String? fullName;
  String? username;
  bool? isVerified;
  String? specialization;
  String? date;
  String? time;
  int? timeInMinutes;
  int? fees;
  int? tax;
  int? totalAmount;
  List<String>? prescriptions;
  String? videoSdkRoomId;
  String? videoSdkToken;

  PastAppointmentResponseModel(
      {this.id,
      this.doctorId,
      this.userId,
      this.profilePic,
      this.fullName,
      this.username,
      this.isVerified,
      this.specialization,
      this.date,
      this.time,
      this.timeInMinutes,
      this.fees,
      this.tax,
      this.totalAmount,
      this.prescriptions,
      this.videoSdkRoomId,
      this.videoSdkToken});

  PastAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    doctorId = json['doctorId'];
    userId = json['userId'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    username = json['username'];
    isVerified = json['isVerified'];
    specialization = json['specialization'];
    date = json['date'];
    time = json['time'];
    timeInMinutes = json['timeInMinutes'];
    fees = json['fees'];
    tax = json['tax'];
    totalAmount = json['totalAmount'];
    if (json['prescriptions'] != null) {
      prescriptions = <String>[];
      json['prescriptions'].forEach((v) {
        prescriptions!.add(v);
      });
    }
    videoSdkRoomId = json['videoSdkRoomId'];
    videoSdkToken = json['videoSdkToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['doctorId'] = doctorId;
    data['userId'] = userId;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    data['username'] = username;
    data['isVerified'] = isVerified;
    data['specialization'] = specialization;
    data['date'] = date;
    data['time'] = time;
    data['timeInMinutes'] = timeInMinutes;
    data['fees'] = fees;
    data['tax'] = tax;
    data['totalAmount'] = totalAmount;
    data['prescriptions'] = prescriptions;
    data['videoSdkRoomId'] = videoSdkRoomId;
    data['videoSdkToken'] = videoSdkToken;
    return data;
  }
}
