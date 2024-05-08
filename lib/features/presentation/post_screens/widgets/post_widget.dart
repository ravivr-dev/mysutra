import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/LikeDislikeButtonWidget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_screen_widgets/user_follow_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class PostWidget extends StatefulWidget {
  final PostEntity postEntity;

  const PostWidget({super.key, required this.postEntity});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is LikeDislikePostLoaded &&
            widget.postEntity.id == state.likeDislikeEntity.postId) {
          widget.postEntity.reInitIsLiked();
        }
        if (state is LikeDislikePostError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Container(
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
                userIdEntity: widget.postEntity.userId,
                isMyPost: widget.postEntity.isMyPost,
                isFollowing: widget.postEntity.isFollowing,
              ),
              component.spacer(height: 10),
              component.text(
                DateFormat('d/M/y')
                    .format(widget.postEntity.updatedAt.toLocal()),
                style: theme.publicSansFonts.mediumStyle(
                  fontColor: AppColors.neutral,
                ),
              ),
              component.text(
                widget.postEntity.content,
                style: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  fontColor: AppColors.color0xFF1E293B,
                ),
              ),
              if (widget.postEntity.mediaUrls.isNotEmpty) ...[
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return component.networkImage(
                        url: widget.postEntity.mediaUrls[index].url ?? '',
                        height: 153,
                        width: 153,
                        borderRadius: 20,
                        fit: BoxFit.fill,
                        errorWidget: component.assetImage(
                            path: Assets.imagesDefaultAvatar),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return component.spacer(width: 10);
                    },
                    itemCount: widget.postEntity.mediaUrls.length,
                  ),
                ),
              ],
              component.spacer(height: 16),
              _buildDivider(),
              component.spacer(height: 12),
              Row(
                children: [
                  LikeDislikeButtonWidget(
                    isLiked: widget.postEntity.isLiked,
                    onTap: () {
                      context
                          .read<PostsCubit>()
                          .likeDislikePost(postId: widget.postEntity.id);
                      // widget.postEntity.reInitIsLiked();
                    },
                  ),
                  component.spacer(width: 4),
                  component.text('${widget.postEntity.totalLikes}',
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 12, fontColor: AppColors.color0xFF111111)),
                  component.spacer(width: 20),
                  component.assetImage(path: Assets.iconsComment),
                  component.spacer(width: 4),
                  component.text('${widget.postEntity.totalComments}',
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 12, fontColor: AppColors.color0xFF111111)),
                  const Spacer(),
                  component.assetImage(path: Assets.iconsShare),
                  component.spacer(width: 4),
                  component.text('${widget.postEntity.totalShares}',
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 12, fontColor: AppColors.color0xFF111111)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0, height: 0);
  }

// Widget _buildLikeButton({required bool isLiked}) {
//   return InkWell(
//     onTap: () {
//       context
//           .read<PostsCubit>()
//           .likeDislikePost(postId: widget.postEntity.id);
//     },
//     child: isLiked
//         ? component.assetImage(path: Assets.iconsVerify)
//         : component.assetImage(path: Assets.iconsHeart),
//   );
// }
}
