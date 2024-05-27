import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity articleEntity;
  final VoidCallback onTap;

  const ArticleWidget(
      {super.key, required this.articleEntity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            component.text(articleEntity.heading,
                style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            component.spacer(height: 8),
            component.text(articleEntity.content,
                style: theme.publicSansFonts.regularStyle(fontSize: 12),
                maxLines: 4,
                overflow: TextOverflow.ellipsis),
            component.divider(
              color: AppColors.dividerColor,
              thickness: 1,
            ),
            BlocConsumer<ArticleCubit, ArticleState>(
              listener: (context, state) {
                if (state is LikeDislikeArticleLoaded &&
                    articleEntity.id! == state.articleId) {
                  articleEntity.reInitIsLiked();
                } else if (state is LikeDislikeArticleError) {
                  showErrorToast(context: context, message: state.error);
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LikeDislikeButtonWidget(
                        isLiked: articleEntity.isLiked,
                        onTap: () {
                          context
                              .read<ArticleCubit>()
                              .likeDislikeArticle(articleId: articleEntity.id!);
                        },
                        likeCount: articleEntity.totalLikes),
                    component.spacer(width: 20),
                    CommentButtonWidget(
                        commentCount: articleEntity.totalComments,
                        onTap: () {}),
                    // const Spacer(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
