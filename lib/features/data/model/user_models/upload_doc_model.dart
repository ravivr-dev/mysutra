class UploadDocModel {
  String? message;
  String? key;
  String? fileUrl;

  UploadDocModel({this.message, this.key, this.fileUrl});

  UploadDocModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    key = json['key'];
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['key'] = key;
    data['fileUrl'] = fileUrl;
    return data;
  }
}
