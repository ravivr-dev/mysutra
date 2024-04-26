class CreateChatModel {
  String? message;
  Data? data;

  CreateChatModel({this.message, this.data});

  CreateChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? connectionId;
  String? appointmentId;
  String? sentBy;
  String? sentTo;
  String? messageType;
  List<String>? mediaUrl;
  String? message;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.connectionId,
      this.appointmentId,
      this.sentBy,
      this.sentTo,
      this.messageType,
      this.mediaUrl,
      this.message,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    connectionId = json['connectionId'];
    appointmentId = json['appointmentId'];
    sentBy = json['sentBy'];
    sentTo = json['sentTo'];
    messageType = json['messageType'];
    mediaUrl = json['mediaUrl'].cast<String>();
    message = json['message'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connectionId'] = connectionId;
    data['appointmentId'] = appointmentId;
    data['sentBy'] = sentBy;
    data['sentTo'] = sentTo;
    data['messageType'] = messageType;
    data['mediaUrl'] = mediaUrl;
    data['message'] = message;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
