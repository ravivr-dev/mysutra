class GeneralModel {
  String? message;
  String? token;

  GeneralModel({this.message, this.token});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }
}
