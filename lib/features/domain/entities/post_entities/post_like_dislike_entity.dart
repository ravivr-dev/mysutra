class PostLikeDislikeEntity {
  final String? likedBy;
  final String postId;
  final String? id;

  PostLikeDislikeEntity({
    this.likedBy,
    required this.postId,
    this.id,
  });
}
