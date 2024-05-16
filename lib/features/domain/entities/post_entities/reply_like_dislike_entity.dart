class ReplyLikeDislikeEntity {
  final String? likedBy;
  final String? postId;
  final String? commentId;
  final String replyId;
  final String? id;

  ReplyLikeDislikeEntity({
    this.likedBy,
    this.postId,
    this.commentId,
    required this.replyId,
    this.id,
  });
}
