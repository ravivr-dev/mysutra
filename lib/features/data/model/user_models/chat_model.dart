class ChatModel {
  String? message;
  int? count;
  List<Data>? data;

  ChatModel({this.message, this.count, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? sId;
  String? connectionId;
  SentBy? sentBy;
  SentTo? sentTo;
  String? messageType;
  List<String>? mediaUrl;
  String? message;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.connectionId,
      this.sentBy,
      this.sentTo,
      this.messageType,
      this.mediaUrl,
      this.message,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    connectionId = json['connectionId'];
    sentBy = json['sentBy'] != null ? SentBy.fromJson(json['sentBy']) : null;
    sentTo = json['sentTo'] != null ? SentTo.fromJson(json['sentTo']) : null;
    messageType = json['messageType'];
    mediaUrl = json['mediaUrl'].cast<String>();
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['connectionId'] = connectionId;
    if (sentBy != null) {
      data['sentBy'] = sentBy!.toJson();
    }
    if (sentTo != null) {
      data['sentTo'] = sentTo!.toJson();
    }
    data['messageType'] = messageType;
    if (mediaUrl != null) {
      data['mediaUrl'] = mediaUrl;
    }
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SentBy {
  String? sId;
  String? profilePic;
  String? fullName;

  SentBy({this.sId, this.profilePic, this.fullName});

  SentBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    return data;
  }
}

class SentTo {
  String? sId;
  String? profilePic;
  String? fullName;

  SentTo({this.sId, this.profilePic, this.fullName});

  SentTo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    return data;
  }
}
