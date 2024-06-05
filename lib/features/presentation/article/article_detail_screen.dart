import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/presentation/article/bottomsheet/edit_delete_bottomsheet.dart';
import 'package:my_sutra/features/presentation/article/create_or_edit_article_screen.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/article_comment_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/send_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;

  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusCtrl = FocusNode();
  ArticleEntity? article;
  bool isLoading = false;
  bool commentButton = false;
  int pagination = 1;
  int limit = 50;
  List<ArticleCommentEntity> comments = [];
  List<Widget> widgets = [];

  @override
  void initState() {
    _loadArticle();
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
    return BlocConsumer<ArticleCubit, ArticleState>(listener: (context, state) {
      if (state is GetArticleDetailLoading) {
        isLoading = true;
      } else if (state is GetArticleDetailLoaded) {
        article = state.article;
        isLoading = false;
        widgets = _processTextWithLinks(state.article.content ?? '');
      } else if (state is GetArticleDetailError) {
        widget.showErrorToast(context: context, message: state.error);
      }

      if (state is GetArticleCommentsLoaded) {
        comments = state.articleComments;
      } else if (state is GetArticleCommentsError) {
        widget.showErrorToast(context: context, message: state.error);
      }

      if (state is WriteCommentLoaded) {
        _loadComments();
        _loadArticle();
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
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(context.stringForKey(StringKeys.article)),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: component.text(article?.heading ?? '',
                              style: theme.publicSansFonts
                                  .semiBoldStyle(fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5),
                        ),
                        if (article?.isMyArticle ?? false)
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return EditDeleteBottomsheet(
                                      articleId: article!.id!,
                                      onTapDelete: () {
                                        AiloitteNavigation.back(context);
                                        _confirmDeleteDialog();
                                      },
                                      onTapEdit: () {
                                        AiloitteNavigation.back(context);
                                        AiloitteNavigation.intentWithData(
                                                context,
                                                AppRoutes
                                                    .createOrEditArticleRoute,
                                                CreateOrEditScreenParams(
                                                    isEditing: true,
                                                    articleId:
                                                        widget.articleId))
                                            .then((value) => _loadArticle());
                                      },
                                    );
                                  });
                            },
                            icon: const Icon(Icons.more_vert),
                            iconSize: 20,
                          ),
                      ],
                    ),
                    _buildInfo(),
                    // component.text(article?.content ?? '',
                    //     style: theme.publicSansFonts.regularStyle(
                    //         fontColor: AppColors.color0xFF636A80,
                    //         fontSize: 14)),
                    if (article != null && article!.mediaUrls.isNotEmpty) ...[
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return component.networkImage(
                              url: article!.mediaUrls[index].url ?? '',
                              // height: 153,
                              // width: context.screenWidth,
                              borderRadius: 20,
                              fit: BoxFit.fitWidth,
                              errorWidget: component.assetImage(
                                  path: Assets.imagesDefaultAvatar),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return component.spacer(width: 10);
                          },
                          itemCount: article!.mediaUrls.length,
                        ),
                      ),
                    ],
                    ...widgets,
                    _buildFooter(),
                    if (comments.isNotEmpty) ...[
                      component.spacer(height: 20),
                      component.text(context.stringForKey(StringKeys.comments),
                          style: theme.publicSansFonts
                              .semiBoldStyle(fontSize: 16)),
                      _buildComment(),
                    ],
                    if (commentButton) ...[_buildWriteYourCommentWidget()],
                  ],
                )),
              ),
      );
    });
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
                    url: article?.userId?.profilePic ?? '',
                    errorWidget: component.assetImage(
                        path: Assets.imagesDefaultAvatar, fit: BoxFit.fill)),
              ),
              component.spacer(width: 8),
              component.text(
                article?.userId?.fullName ?? article?.userId?.username,
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
                article!.id == state.articleId) {
              article!.reInitIsLiked();
            } else if (state is LikeDislikeArticleError) {
              widget.showErrorToast(context: context, message: state.error);
            }
          },
          builder: (context, state) {
            return Row(
              children: [
                LikeDislikeButtonWidget(
                    isLiked: article?.isLiked ?? false,
                    onTap: () {
                      context
                          .read<ArticleCubit>()
                          .likeDislikeArticle(articleId: article!.id!);
                    },
                    likeCount: article?.totalLikes ?? 0),
                component.spacer(width: 20),
                CommentButtonWidget(
                    commentCount: article?.totalComments ?? 0,
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
                    articleId: article!.id!, comment: _commentController.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loadComments() {
    context.read<ArticleCubit>().getArticleComments(
        articleId: widget.articleId, pagination: pagination, limit: limit);
  }

  void _loadArticle() {
    context.read<ArticleCubit>().getArticleDetail(articleId: widget.articleId);
  }

  void _confirmDeleteDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            iconPadding: const EdgeInsets.only(top: 40, bottom: 25),
            content: component.text(
              "Are you sure you want to delete ?",
              style: theme.publicSansFonts
                  .regularStyle(fontSize: 16, fontColor: Colors.grey),
              textAlign: TextAlign.center,
            ),
            actionsPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context
                          .read<ArticleCubit>()
                          .deleteArticle(articleId: widget.articleId);
                      AiloitteNavigation.back(context);
                    },
                    child: Text(
                      'Yes',
                      style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    child: Text(
                      "No",
                      style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  List<Widget> _processTextWithLinks(String text) {
    final urlRegex = RegExp(
      r'(?:https?|ftp)://[^\s/$.?#].\S*',
      caseSensitive: false,
    );
    // final imageUrlRegex = RegExp(
    //   r'(?:https?|ftp)://[^\s/$.?#].\S*\.(?:jpg|jpeg|png|gif)',
    //   caseSensitive: false,
    // );

    List<Widget> widgets = [];
    final matches = urlRegex.allMatches(text);

    int lastMatchEnd = 0;

    for (var match in matches) {
      if (lastMatchEnd != match.start) {
        widgets.add(_buildRichText(text.substring(lastMatchEnd, match.start)));
      }

      final matchedText = text.substring(match.start, match.end);

      if (urlRegex.hasMatch(matchedText)) {
        //   widgets.add(
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Image.network(matchedText),
        //     ),
        //   );
        // } else {
        widgets.add(
          GestureDetector(
            onTap: () => Utils.launchURL(matchedText),
            child: Text(
              matchedText,
              style: const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        );
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd != text.length) {
      widgets.add(_buildRichText(text.substring(lastMatchEnd)));
    }

    return widgets;
  }

  Widget _buildRichText(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: AppColors.color0xFF636A80, fontSize: 14),
      ),
    );
  }
}
