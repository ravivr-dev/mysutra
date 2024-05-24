import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_reply_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/send_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/user_follow_widget.dart';

class PostCommentWidget extends StatefulWidget {
  final CommentEntity commentEntity;
  final String postId;

  const PostCommentWidget(
      {super.key, required this.commentEntity, required this.postId});

  @override
  State<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
  final TextEditingController _replyController = TextEditingController();
  bool reply = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is LikeDislikeCommentLoaded &&
            widget.commentEntity.id == state.commentEntity.commentId) {
          widget.commentEntity.reInitIsLiked();
        } else if (state is LikeDislikeCommentError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is NewReplyLoaded) {
          context
              .read<PostsCubit>()
              .getComments(postId: widget.postId, pagination: 1, limit: 50);
          _replyController.clear();
        } else if (state is NewReplyError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.color0xFFE2E8F0),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCommentWidget(context),
              if (widget.commentEntity.replies.isNotEmpty) ...[
                component.spacer(height: 16),
                const Divider(color: AppColors.color0xFFEAECF0),
                component.spacer(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.commentEntity.replies.length,
                    itemBuilder: (context, index) {
                      return PostReplyWidget(
                          reply: widget.commentEntity.replies[index]);
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
      },
    );
  }

  Widget _buildCommentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserFollowWidget(
          userIdEntity: widget.commentEntity.userId,
          isMyPost: widget.commentEntity.isMyComment,
          isFollowing: widget.commentEntity.isFollowing,
          isPost: false,
          userFollowing: (_) {
            setState(() {
              widget.commentEntity.reInitIsFollowing();
            });
          },
        ),
        component.spacer(height: 10),
        component.text(
            DateFormat('d/M/y').format(widget.commentEntity.updatedAt),
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.neutral,
            )),
        component.spacer(height: 8),
        component.text(
          widget.commentEntity.comment,
          style: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF1E293B,
          ),
        ),
        component.spacer(height: 12),
        Row(
          children: [
            LikeDislikeButtonWidget(
                isLiked: widget.commentEntity.isLiked,
                onTap: () {
                  context
                      .read<PostsCubit>()
                      .likeDislikeComment(commentId: widget.commentEntity.id);
                },
                likeCount: widget.commentEntity.totalLikes),
            component.spacer(width: 20),
            CommentButtonWidget(
                commentCount: widget.commentEntity.totalReplies,
                onTap: () {}),
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  reply = !reply;
                });
              },
              child: component.text(context.stringForKey(StringKeys.reply),
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 16, fontColor: AppColors.primaryColor)),
            ),
          ],
        ),
        if (reply) ...[
          component.spacer(height: 20),
          _buildWriteYourReplyWidget(),
        ],
      ],
    );
  }

  Widget _buildWriteYourReplyWidget() {
    return Container(
      height: 60,
      // margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(color: AppColors.greyD9)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: component.textField(
            controller: _replyController,
            contentPadding: EdgeInsets.zero,
            hintText: "Write your reply",
            hintTextStyle: theme.publicSansFonts
                .regularStyle(fontSize: 16, fontColor: AppColors.black81),
            borderColor: AppColors.transparent,
            focusedBorderColor: AppColors.transparent,
          )),
          SendButtonWidget(
            onTap: () {
              context.read<PostsCubit>().newReply(
                  commentId: widget.commentEntity.id,
                  reply: _replyController.text);
            },
          ),
        ],
      ),
    );
  }
}
