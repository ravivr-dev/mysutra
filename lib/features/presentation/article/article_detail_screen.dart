import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/presentation/article/bottomsheet/edit_delete_bottomsheet.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/article_comment_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/send_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusCtrl = FocusNode();
  bool commentButton = false;
  int pagination = 1;
  int limit = 50;
  List<ArticleCommentEntity> comments = [];

  @override
  void initState() {
    _loadComments();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: BlocConsumer<ArticleCubit, ArticleState>(
            listener: (context, state) {
              if (state is GetArticleCommentsLoaded) {
                comments = state.articleComments;
              } else if (state is GetArticleCommentsError) {
                widget.showErrorToast(context: context, message: state.error);
              }

              if (state is WriteCommentLoaded) {
                _loadComments();
                _commentController.clear();
                _commentFocusCtrl.unfocus();
              } else if (state is WriteCommentError) {
                widget.showErrorToast(context: context, message: state.error);
              }

              if (state is DeleteArticleLoaded) {
                AiloitteNavigation.back(context);
              } else if (state is DeleteArticleError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeading(context),
                  _buildInfo(),
                  component.text(widget.article.content,
                      style: theme.publicSansFonts.regularStyle(
                          fontColor: AppColors.color0xFF636A80, fontSize: 14)),
                  _buildFooter(),
                  if (comments.isNotEmpty) ...[
                    component.spacer(height: 20),
                    component.text(context.stringForKey(StringKeys.comments),
                        style:
                            theme.publicSansFonts.semiBoldStyle(fontSize: 16)),
                    _buildComment(),
                  ],
                  if (commentButton) ...[_buildWriteYourCommentWidget()],
                ],
              );
            },
          ),
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
        InkWell(
          onTap: () {},
          child: Row(
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
        ),
        component.divider(
            color: AppColors.dividerColor, thickness: 1, height: 30),
        BlocConsumer<ArticleCubit, ArticleState>(
          listener: (context, state) {
            if (state is LikeDislikeArticleLoaded &&
                widget.article.id == state.articleId) {
              widget.article.reInitIsLiked();
            } else if (state is LikeDislikeArticleError) {
              widget.showErrorToast(context: context, message: state.error);
            }
          },
          builder: (context, state) {
            return Row(
              children: [
                LikeDislikeButtonWidget(
                    isLiked: widget.article.isLiked,
                    onTap: () {
                      context
                          .read<ArticleCubit>()
                          .likeDislikeArticle(articleId: widget.article.id!);
                    },
                    likeCount: widget.article.totalLikes),
                component.spacer(width: 20),
                CommentButtonWidget(
                    commentCount: widget.article.totalComments,
                    onTap: () {
                      _commentFocusCtrl.requestFocus();
                      if (!commentButton) {
                        setState(() {
                          commentButton = true;
                        });
                      }
                    }),
              ],
            );
          },
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
            component.text('Share : ',
                style: theme.publicSansFonts.semiBoldStyle(fontSize: 16))
          ],
        )
      ],
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: component.text(widget.article.heading,
              style: theme.publicSansFonts.semiBoldStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 5),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return EditDeleteBottomsheet(
                    articleId: widget.article.id!,
                  );
                });
          },
          icon: const Icon(Icons.more_vert),
          iconSize: 20,
        ),
      ],
    );
  }

  Widget _buildComment() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ArticleCommentWidget(comment: comments[index]);
      },
      itemCount: comments.length,
    );
  }

  Widget _buildWriteYourCommentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: AppColors.greyD9)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: component.textField(
              focusNode: _commentFocusCtrl,
              controller: _commentController,
              contentPadding: EdgeInsets.zero,
              hintText: context.stringForKey(StringKeys.writeYourComment),
              hintTextStyle: theme.publicSansFonts
                  .regularStyle(fontSize: 16, fontColor: AppColors.black81),
              borderColor: AppColors.transparent,
              focusedBorderColor: AppColors.transparent,
            )),
            SendButtonWidget(
              onTap: () {
                context.read<ArticleCubit>().writeComment(
                    articleId: widget.article.id!,
                    comment: _commentController.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loadComments() {
    context.read<ArticleCubit>().getArticleComments(
        articleId: widget.article.id!, pagination: pagination, limit: limit);
  }
}
