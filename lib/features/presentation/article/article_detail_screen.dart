import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(context.stringForKey(StringKeys.article)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            component.text(widget.article.heading,
                style: theme.publicSansFonts.semiBoldStyle(fontSize: 20)),
            _buildInfo(),
            component.text(widget.article.content,
                style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.color0xFF636A80, fontSize: 14)),
            const Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      children: [
        component.divider(
          color: AppColors.dividerColor,
          thickness: 1,
          height: 40,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.transparent,
              child: component.networkImage(
                  isCircular: true,
                  borderRadius: 20,
                  url: widget.article.userId!.profilePic!,
                  errorWidget: component.assetImage(
                      path: Assets.imagesDefaultAvatar, fit: BoxFit.fill)),
            ),
            component.spacer(width: 8),
            component.text(
              widget.article.userId!.fullName ??
                  widget.article.userId!.username,
              style: theme.publicSansFonts.mediumStyle(fontSize: 16),
            ),
          ],
        ),
        component.divider(
            color: AppColors.dividerColor, thickness: 1, height: 30),
        Row(
          children: [
            LikeDislikeButtonWidget(
                isLiked: widget.article.isLiked!,
                onTap: () {},
                likeCount: widget.article.totalLikes!),
            component.spacer(width: 20),
            CommentButtonWidget(
                commentCount: widget.article.totalComments!, onTap: () {}),
          ],
        ),
        component.divider(
            color: AppColors.dividerColor, thickness: 1, height: 20),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        component.divider(
            color: AppColors.dividerColor, thickness: 1, height: 40),
        Row(
          children: [
            component.text('',
                style: theme.publicSansFonts.semiBoldStyle(fontSize: 16))
          ],
        )
      ],
    );
  }
}
