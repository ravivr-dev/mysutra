class ArticleMediaUrlsModel {
  String? mediaType;
  String? url;

  ArticleMediaUrlsModel({this.mediaType, this.url});

  ArticleMediaUrlsModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaType'] = mediaType;
    data['url'] = url;
    return data;
  }
}
