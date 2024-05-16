import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_detail_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/send_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/share_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/user_follow_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class RepostScreen extends StatefulWidget {
  final String postId;

  const RepostScreen({super.key, required this.postId});

  @override
  State<RepostScreen> createState() => _RepostScreenState();
}

class _RepostScreenState extends State<RepostScreen> {
  PostDetailEntity? postDetail;

  @override
  void initState() {
    context.read<PostsCubit>().getPostDetail(postId: widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is GetPostDetailLoaded) {
          postDetail = state.post;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Repost'),
            leading: IconButton(
              onPressed: () {
                AiloitteNavigation.back(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: Column(
            children: [
              if (postDetail == null) ...[
                const Center(
                  child: CircularProgressIndicator(),
                )
              ] else ...[
                _buildPostWidget(),
              ]
            ],
          ),
          floatingActionButton: SendButtonWidget(
            onTap: () {},
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
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

  Widget _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0, height: 0);
  }
}
