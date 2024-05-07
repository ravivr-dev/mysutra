class PostEntity {
  String id;
  UserId userId;
  bool isFollowing;
  String content;
  List<MediaUrl> mediaUrls;
  List<String> taggedUserIds;
  int totalLikes;
  int totalComments;
  int totalShares;
  bool isMyPost;
  DateTime createdAt;
  DateTime updatedAt;

  PostEntity({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.content,
    required this.mediaUrls,
    required this.taggedUserIds,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.isMyPost,
    required this.createdAt,
    required this.updatedAt,
  });

}

class MediaUrl {
  String mediaType;
  String url;

  MediaUrl({
    required this.mediaType,
    required this.url,
  });
  Map<String, dynamic> toJson() => {
    "mediaType": mediaType,
    "url": url,
  };
}

class UserId {
  String id;
  String role;
  String profilePic;
  String fullName;
  String username;
  bool isVerified;

  UserId({
    required this.id,
    required this.role,
    required this.profilePic,
    required this.fullName,
    required this.username,
    required this.isVerified,
  });

}