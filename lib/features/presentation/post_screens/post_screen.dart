import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/comment_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_comment_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/user_follow_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/send_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/share_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class PostScreen extends StatefulWidget {
  final String postId;

  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _commentController = TextEditingController();
  PostDetailEntity? postDetail;
  List<CommentEntity> comments = [];

  @override
  void initState() {
    _loadPostDetails();
    super.initState();
  }

  void _loadPostDetails() {
    context.read<PostsCubit>().getPostDetail(postId: widget.postId);
    context
        .read<PostsCubit>()
        .getComments(postId: widget.postId, pagination: 1, limit: 100);
    setState(() {});
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
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: AppColors.color0xFF00082F.withOpacity(.27)),
          onPressed: () {
            AiloitteNavigation.back(context);
          },
        ),
        title: component.text(context.stringForKey(StringKeys.post),
            style: theme.publicSansFonts.mediumStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          child: BlocConsumer<PostsCubit, PostsState>(
            listener: (context, state) {
              if (state is GetPostDetailLoaded) {
                postDetail = state.post;
              }
              if (state is GetCommentLoaded) {
                comments = state.comments;
              }
              if (state is GetCommentError) {
                widget.showErrorToast(context: context, message: state.error);
              }

              if (state is NewCommentLoaded) {
                _loadPostDetails();
                _commentController.clear();
              }

              if (state is NewCommentError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            builder: (context, state) {
              return postDetail == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        _buildPostWidget(),
                        component.spacer(height: 12),
                        _buildCommentWidget()
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCommentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWriteYourCommentWidget(),
          if (comments.isNotEmpty) ...[
            component.spacer(height: 16),
            _buildDivider(),
            component.spacer(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: component.text(context.stringForKey(StringKeys.comments),
                  style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
            ),
            component.spacer(height: 16),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PostCommentWidget(
                    commentEntity: comments[index],
                    postId: widget.postId,
                  );
                },
                separatorBuilder: (_, index) {
                  return Column(
                    children: [
                      component.spacer(height: 14),
                      _buildDivider(),
                      component.spacer(height: 14),
                    ],
                  );
                },
                itemCount: comments.length),
          ]
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0, height: 0);
  }

  // Widget _buildComments() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24),
  //     child: Column(
  //       children: [
  //         const PostCommentWidget(),
  //         component.spacer(height: 14),
  //         _buildDivider(),
  //         component.spacer(height: 14),
  //         const PostCommentWidget()
  //       ],
  //     ),
  //   );
  // }

  Widget _buildWriteYourCommentWidget() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 24),
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
              context.read<PostsCubit>().newComment(
                  postId: widget.postId, comment: _commentController.text);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.color0xFFE2E8F0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserFollowWidget(
            postId: postDetail!.id,
            userIdEntity: postDetail!.userId,
            isMyPost: postDetail!.isMyPost,
            isFollowing: postDetail!.isFollowing,
            userFollowing: (_) {
              setState(() {
                postDetail!.reInitIsFollowing();
              });
            },
          ),
          component.spacer(height: 10),
          component.text(DateFormat('d/M/y').format(postDetail!.updatedAt),
              style: theme.publicSansFonts.mediumStyle(
                fontColor: AppColors.neutral,
              )),
          component.spacer(height: 10),
          component.text(postDetail!.content,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 16,
                fontColor: AppColors.color0xFF1E293B,
              )),
          component.spacer(height: 16),
          if (postDetail!.mediaUrls.isNotEmpty) ...[
            SizedBox(
              height: 150,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return component.networkImage(
                    url: postDetail!.mediaUrls[index].url ?? '',
                    height: 153,
                    width: 153,
                    borderRadius: 20,
                    fit: BoxFit.fill,
                    errorWidget:
                        component.assetImage(path: Assets.imagesDefaultAvatar),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return component.spacer(width: 10);
                },
                itemCount: postDetail!.mediaUrls.length,
              ),
            ),
          ],
          component.spacer(height: 12),
          _buildDivider(),
          component.spacer(height: 12),
          Row(
            children: [
              LikeDislikeButtonWidget(
                  isLiked: postDetail!.isLiked,
                  onTap: () {},
                  likeCount: postDetail!.totalLikes),
              component.spacer(width: 20),
              CommentButtonWidget(
                commentCount: postDetail!.totalComments,
                postId: postDetail!.id,
                onTap: () {},
              ),
              const Spacer(),
              ShareButtonWidget(shareCount: postDetail!.totalShares),
            ],
          )
        ],
      ),
    );
  }
}
