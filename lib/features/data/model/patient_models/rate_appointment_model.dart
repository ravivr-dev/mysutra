class RateAppointmentModel {
  String? message;
  RateAppointmentData? data;

  RateAppointmentModel({this.message, this.data});

  RateAppointmentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? RateAppointmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RateAppointmentData {
  String? appointmentId;
  String? doctorId;
  String? userId;
  int? ratings;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RateAppointmentData(
      {this.appointmentId,
      this.doctorId,
      this.userId,
      this.ratings,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RateAppointmentData.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
    doctorId = json['doctorId'];
    userId = json['userId'];
    ratings = json['ratings'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentId'] = appointmentId;
    data['doctorId'] = doctorId;
    data['userId'] = userId;
    data['ratings'] = ratings;
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
