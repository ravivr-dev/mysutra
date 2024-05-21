import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/reply_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/user_follow_widget.dart';

class PostReplyWidget extends StatelessWidget {
  final ReplyEntity reply;

  const PostReplyWidget({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is LikeDislikeReplyLoaded &&
            reply.id == state.replyEntity.replyId) {
          reply.reInitIsLiked();
        } else if (state is LikeDislikeReplyError) {
          showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserFollowWidget(
              userIdEntity: reply.userId,
              isMyPost: reply.isMyReply,
              isFollowing: reply.isFollowing,
              isPost: false,
            ),
            component.spacer(height: 10),
            component.text(DateFormat('d/M/y').format(reply.updatedAt),
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
            LikeDislikeButtonWidget(
                isLiked: reply.isLiked,
                onTap: () {
                  context
                      .read<PostsCubit>()
                      .likeDislikeReply(replyId: reply.id);
                },
                likeCount: reply.totalLikes),
          ],
        );
      },
    );
  }
}
