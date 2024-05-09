class MediaUrlEntity {
  String? mediaType;
  String? url;

  MediaUrlEntity({
    this.mediaType,
    this.url,
  });

  Map<String, dynamic> toJson() => {
    "mediaType": mediaType,
    "url": url,
  };
}