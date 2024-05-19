import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/user_follow_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/share_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

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
        } else if (state is LikeDislikePostError) {
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
              BlocProvider<SearchDoctorCubit>(
                create: (context) => sl<SearchDoctorCubit>(),
                child: UserFollowWidget(
                  userIdEntity: widget.postEntity.userId,
                  isMyPost: widget.postEntity.isMyPost,
                  isFollowing: widget.postEntity.isFollowing,
                  postId: widget.postEntity.id,
                  userFollowing: (_) {
                    setState(() {
                      widget.postEntity.reInitIsFollowing();
                    });
                  },
                ),
              ),
              component.spacer(height: 10),
              component.text(
                DateFormat('d/M/y')
                    .format(widget.postEntity.updatedAt.toLocal()),
                style: theme.publicSansFonts.mediumStyle(
                  fontColor: AppColors.neutral,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.postRoute,
                          arguments: widget.postEntity.id)
                      .then((_) => context
                          .read<PostsCubit>()
                          .getPosts(pagination: 1, limit: 50));
                },
                child: SizedBox(
                  width: context.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                url: widget.postEntity.mediaUrls[index].url ??
                                    '',
                                height: 153,
                                width: 153,
                                borderRadius: 20,
                                fit: BoxFit.fill,
                                errorWidget: component.assetImage(
                                    path: Assets.imagesDefaultAvatar),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return component.spacer(width: 10);
                            },
                            itemCount: widget.postEntity.mediaUrls.length,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              component.spacer(height: 16),
              if (widget.postEntity.postId != null) ...[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.postRoute,
                        arguments: widget.postEntity.postId!.id)
                        .then((_) => context
                        .read<PostsCubit>()
                        .getPosts(pagination: 1, limit: 50));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.color0xFFE2E8F0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocProvider<SearchDoctorCubit>(
                          create: (context) => sl<SearchDoctorCubit>(),
                          child: UserFollowWidget(
                            userIdEntity: widget.postEntity.postId!.userId,
                            isMyPost: true,
                            isFollowing: false,
                            isPost: false,
                            postId: widget.postEntity.postId!.id,
                            userFollowing: (_) {},
                          ),
                        ),
                        component.spacer(height: 10),
                        component.text(
                          DateFormat('d/M/y').format(
                              widget.postEntity.postId!.updatedAt.toLocal()),
                          style: theme.publicSansFonts.mediumStyle(
                            fontColor: AppColors.neutral,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            component.text(
                              widget.postEntity.postId!.content,
                              style: theme.publicSansFonts.regularStyle(
                                fontSize: 16,
                                fontColor: AppColors.color0xFF1E293B,
                              ),
                            ),
                            if (widget
                                .postEntity.postId!.mediaUrls.isNotEmpty) ...[
                              SizedBox(
                                height: 150,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return component.networkImage(
                                      url: widget.postEntity.postId!
                                              .mediaUrls[index].url ??
                                          '',
                                      height: 153,
                                      width: 153,
                                      borderRadius: 20,
                                      fit: BoxFit.fill,
                                      errorWidget: component.assetImage(
                                          path: Assets.imagesDefaultAvatar),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return component.spacer(width: 10);
                                  },
                                  itemCount: widget
                                      .postEntity.postId!.mediaUrls.length,
                                ),
                              ),
                            ],
                          ],
                        ),
                        // component.spacer(height: 12),
                        // Row(
                        //   children: [
                        //     LikeDislikeButtonWidget(
                        //       isLiked: false,
                        //       onTap: () {},
                        //       likeCount: widget.postEntity.postId!.totalLikes,
                        //     ),
                        //     component.spacer(width: 10),
                        //     CommentButtonWidget(
                        //       commentCount:
                        //           widget.postEntity.postId!.totalComments,
                        //       postId: widget.postEntity.postId!.id,
                        //       onTap: () {},
                        //     ),
                        //     const Spacer(),
                        //     ShareButtonWidget(
                        //       shareCount: widget.postEntity.postId!.totalShares,
                        //       onTap: () {},
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              ] else ...[
                _buildDivider(),
              ],
              component.spacer(height: 12),
              Row(
                children: [
                  LikeDislikeButtonWidget(
                    isLiked: widget.postEntity.isLiked,
                    onTap: () {
                      context
                          .read<PostsCubit>()
                          .likeDislikePost(postId: widget.postEntity.id);
                    },
                    likeCount: widget.postEntity.totalLikes,
                  ),
                  component.spacer(width: 10),
                  CommentButtonWidget(
                    commentCount: widget.postEntity.totalComments,
                    postId: widget.postEntity.id,
                    onTap: () {
                      AiloitteNavigation.intentWithData(context,
                              AppRoutes.postRoute, widget.postEntity.id)
                          .then((_) => context
                              .read<PostsCubit>()
                              .getPosts(pagination: 1, limit: 50));
                    },
                  ),
                  const Spacer(),
                  ShareButtonWidget(
                    shareCount: widget.postEntity.totalShares,
                    onTap: () {
                      AiloitteNavigation.intentWithData(
                          context, AppRoutes.repostRoute, widget.postEntity);
                    },
                  ),
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
}
