class ChatEntity {
  String? appointmentId;
  String? sentTo;
  String? messageType;
  String? message;
  List<String>? mediaUrl;

  ChatEntity(
      {this.appointmentId,
      this.sentTo,
      this.messageType,
      this.message,
      this.mediaUrl});

  ChatEntity.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
    sentTo = json['sentTo'];
    messageType = json['messageType'];
    message = json['message'];
    mediaUrl = json['mediaUrl'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentId'] = appointmentId;
    data['sentTo'] = sentTo;
    data['messageType'] = messageType;
    data['message'] = message;
    data['mediaUrl'] = mediaUrl;
    return data;
  }
}
