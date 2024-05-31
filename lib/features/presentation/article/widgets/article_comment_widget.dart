import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_comment_entity.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/article_reply_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/send_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class ArticleCommentWidget extends StatefulWidget {
  final ArticleCommentEntity comment;

  const ArticleCommentWidget({super.key, required this.comment});

  @override
  State<ArticleCommentWidget> createState() => _ArticleCommentWidgetState();
}

class _ArticleCommentWidgetState extends State<ArticleCommentWidget> {
  final TextEditingController _replyCtrl = TextEditingController();
  bool replyButton = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleCubit, ArticleState>(
      listener: (context, state) {
        if (state is LikeDislikeCommentLoaded &&
            state.commentId == widget.comment.id) {
          widget.comment.reInitIsLiked();
        } else if (state is LikeDislikeCommentError) {
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildComment(),
            if (widget.comment.replies!.isNotEmpty) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const ArticleReplyWidget();
                },
                itemCount: widget.comment.replies!.length,
              ),
            ],
          ]),
        );
      },
    );
  }

  Widget _buildComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            component.networkImage(
              height: 30,
              width: 30,
              borderRadius: 10,
              fit: BoxFit.fill,
              url: widget.comment.userId?.profilePic ?? '',
              errorWidget: component.assetImage(
                  path: Assets.imagesDefaultAvatar, fit: BoxFit.fill),
            ),
            component.spacer(width: 10),
            component.text(widget.comment.userId?.fullName ??
                widget.comment.userId?.username ??
                '')
          ],
        ),
        component.spacer(height: 10),
        component.text(
            Utils.formatElapsedTime(
                DateTime.parse(widget.comment.updatedAt!).toLocal()),
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.neutral,
            )),
        component.spacer(height: 8),
        component.text(
          widget.comment.comment,
          style: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF1E293B,
          ),
        ),
        component.spacer(height: 12),
        LikeDislikeButtonWidget(
            isLiked: widget.comment.isLiked,
            onTap: () {
              context
                  .read<ArticleCubit>()
                  .likeDislikeComment(commentId: widget.comment.id!);
            },
            likeCount: widget.comment.totalLikes),
        // Row(
        //   children: [
        //     const Spacer(),
        //     // InkWell(
        //     //   onTap: () {
        //     //     setState(() {
        //     //       replyButton = !replyButton;
        //     //     });
        //     //   },
        //     //   child: component.text(context.stringForKey(StringKeys.reply),
        //     //       style: theme.publicSansFonts.mediumStyle(
        //     //           fontSize: 16, fontColor: AppColors.primaryColor)),
        //     // ),
        //   ],
        // ),
        if (replyButton) ...[
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
            controller: _replyCtrl,
            contentPadding: EdgeInsets.zero,
            hintText: "Write your reply",
            hintTextStyle: theme.publicSansFonts
                .regularStyle(fontSize: 16, fontColor: AppColors.black81),
            borderColor: AppColors.transparent,
            focusedBorderColor: AppColors.transparent,
          )),
          SendButtonWidget(
            onTap: () {
              // context.read<PostsCubit>().newReply(
              //     commentId: widget.commentEntity.id,
              //     reply: _replyCtrl.text);
            },
          ),
        ],
      ),
    );
  }
}
