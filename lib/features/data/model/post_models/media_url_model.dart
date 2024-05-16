import 'dart:convert';

class MediaUrlModel {
  final String mediaType;
  final String url;

  MediaUrlModel({
    required this.mediaType,
    required this.url,
  });

  factory MediaUrlModel.fromRawJson(String str) =>
      MediaUrlModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaUrlModel.fromJson(Map<String, dynamic> json) => MediaUrlModel(
        mediaType: json["mediaType"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mediaType": mediaType,
        "url": url,
      };
}
