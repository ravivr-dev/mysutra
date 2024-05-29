class LikeDislikeArticleCommentEntity {
  String? likedBy;
  String? articleId;
  String? commentId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LikeDislikeArticleCommentEntity(
      {this.likedBy,
        this.articleId,
        this.commentId,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.iV});
}
