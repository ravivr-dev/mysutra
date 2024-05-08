class LikeDislikeEntity {
  final String? likedBy;
  final String postId;
  final String? id;

  LikeDislikeEntity({
    this.likedBy,
    required this.postId,
    this.id,
  });
}
