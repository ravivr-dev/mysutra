class ArticleMediaUrlEntity {
  String? mediaType;
  String? url;

  ArticleMediaUrlEntity({
    this.mediaType,
    this.url,
  });

  Map<String, dynamic> toJson() => {
    "mediaType": mediaType,
    "url": url,
  };
}