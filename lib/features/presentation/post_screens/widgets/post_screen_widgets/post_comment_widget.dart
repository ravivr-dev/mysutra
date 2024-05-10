import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_screen_widgets/user_follow_widget.dart';
import '../../../../../ailoitte_component_injector.dart';
import '../../../../../core/utils/app_colors.dart';

class PostCommentWidget extends StatelessWidget {
  final CommentEntity commentEntity;

  const PostCommentWidget({super.key, required this.commentEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.color0xFFE2E8F0),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommentWidget(context),
          if (commentEntity.replies.isNotEmpty) ...[
            component.spacer(height: 16),
            const Divider(color: AppColors.color0xFFEAECF0),
            component.spacer(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: commentEntity.replies.length,
                itemBuilder: (context, index) {
                  return _buildReplyWidget(context,
                      reply: commentEntity.replies[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      component.spacer(height: 16),
                      const Divider(color: AppColors.color0xFFEAECF0),
                      component.spacer(height: 16),
                    ],
                  );
                },
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildCommentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserFollowWidget(
          userIdEntity: commentEntity.userId,
          isMyPost: commentEntity.isMyComment,
          isFollowing: commentEntity.isFollowing,
        ),
        component.spacer(height: 10),
        component.text(DateFormat('d/m/y').format(commentEntity.updatedAt),
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.neutral,
            )),
        component.spacer(height: 8),
        component.text(
          commentEntity.comment,
          style: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF1E293B,
          ),
        ),
        component.spacer(height: 12),
        Row(
          children: [
            LikeDislikeButtonWidget(
                isLiked: commentEntity.isLiked,
                onTap: () {},
                likeCount: commentEntity.totalLikes),
            component.spacer(width: 20),
            CommentButtonWidget(
                commentCount: commentEntity.totalReplies,
                postId: commentEntity.id,
                onTap: () {}),
            const Spacer(),
            component.text(context.stringForKey(StringKeys.reply),
                style: theme.publicSansFonts.mediumStyle(
                    fontSize: 16, fontColor: AppColors.primaryColor)),
          ],
        ),
      ],
    );
  }

  Widget _buildReplyWidget(BuildContext context, {required ReplyEntity reply}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserFollowWidget(
          userIdEntity: reply.userId,
          isMyPost: reply.isMyReply,
          isFollowing: reply.isFollowing,
        ),
        component.spacer(height: 10),
        component.text(DateFormat('d/m/y').format(commentEntity.updatedAt),
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.neutral,
            )),
        component.spacer(height: 8),
        component.text(
          reply.reply,
          style: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF1E293B,
          ),
        ),
        component.spacer(height: 12),
        Row(
          children: [
            LikeDislikeButtonWidget(
                isLiked: commentEntity.isLiked,
                onTap: () {},
                likeCount: commentEntity.totalLikes),
            component.spacer(width: 20),
            CommentButtonWidget(
                commentCount: commentEntity.totalReplies,
                postId: commentEntity.id,
                onTap: () {}),
          ],
        ),
      ],
    );
  }
}
