import 'package:my_sutra/features/data/model/article_models/articles_model.dart';

class ArticleDetailModel {
  String? message;
  ArticleData? data;

  ArticleDetailModel({this.message, this.data});

  ArticleDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ArticleData.fromJson(json['data']) : null;
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
