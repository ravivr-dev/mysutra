class SuccessMessageModel {
  String? message;

  SuccessMessageModel({this.message});

  SuccessMessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
