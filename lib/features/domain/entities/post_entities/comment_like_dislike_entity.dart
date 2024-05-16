class CommentLikeDislikeEntity {
  final String? likedBy;
  final String? postId;
  final String commentId;
  final String? id;

  CommentLikeDislikeEntity({
    this.likedBy,
    this.postId,
    required this.commentId,
    this.id,
  });
}
