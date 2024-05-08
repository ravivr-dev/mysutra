class PostEntity {
  String id;
  UserIdEntity userId;
  bool isFollowing;
  String? content;
  List<MediaUrlEntity> mediaUrls;
  List<String>? taggedUserIds;
  int totalLikes;
  int totalComments;
  int totalShares;
  bool isMyPost;
  bool isLiked;
  DateTime? createdAt;
  DateTime updatedAt;

  PostEntity({
    required this.id,
    required this.userId,
    required this.isFollowing,
    required this.content,
    required this.mediaUrls,
    this.taggedUserIds,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
    required this.isMyPost,
    required this.isLiked,
    this.createdAt,
    required this.updatedAt,
  });

  void reInitIsFollowing() {
    isFollowing = !isFollowing;
  }

  void reInitIsLiked() {
    isLiked = !isLiked;

    if (isLiked) {
      totalLikes += 1;
    } else {
      totalLikes -= 1;
    }
  }
}

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

class UserIdEntity {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  bool isVerified;

  UserIdEntity({
    this.id,
    this.role,
    this.profilePic,
    this.fullName,
    this.username,
    required this.isVerified,
  });
}
