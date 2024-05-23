import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/share_button_widget.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      margin: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          component.text('Headline',
              style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
          component.text('Content',
              style: theme.publicSansFonts.regularStyle(fontSize: 12)),
          component.divider(),
          Row(
            children: [
              LikeDislikeButtonWidget(
                  isLiked: true, onTap: () {}, likeCount: 25),
              component.spacer(width: 20),
              CommentButtonWidget(commentCount: 30, postId: '', onTap: () {}),
              const Spacer(),
              const ShareButtonWidget(shareCount: 34),
            ],
          )
        ],
      ),
    );
  }
}
