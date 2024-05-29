import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/comment_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/like_dislike_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/share_button_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/user_follow_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class RePostScreen extends StatefulWidget {
  final PostEntity postEntity;

  const RePostScreen({super.key, required this.postEntity});

  @override
  State<RePostScreen> createState() => _RePostScreenState();
}

class _RePostScreenState extends State<RePostScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();
  final List<MediaUrlEntity> mediaUrls = [];
  final List<String> taggedUserIds = [];
  PostEntity? postEntity;

  // bool _isKeyboardOpen = false;

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is RePostLoaded) {
          AiloitteNavigation.back(context);
        }
        if (state is RePostError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  AiloitteNavigation.back(context);
                },
                icon: const Icon(Icons.close, color: AppColors.black01)),
            title: component.text(context.stringForKey(StringKeys.repost)),
            backgroundColor: AppColors.white,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 22,
                          ),
                          component.spacer(width: 10),
                          Form(
                            key: _key,
                            child: Expanded(
                              child: _buildTextField(),
                            ),
                          )
                        ],
                      ),
                      component.spacer(height: 20),
                      _buildPostWidget(),
                    ],
                  ),
                ),
              ),
              _buildSenderWidget()
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField() {
    return component.textField(
      controller: _postController,
      fillColor: AppColors.white,
      // onTapCallback: () => setState(() => _isKeyboardOpen = true),
      hintText: 'Enter Text Here...',
      borderRadius: 10,
      filled: true,
      focusedBorderColor: AppColors.white,
      borderColor: AppColors.white,
      validator: (val) =>
          val!.trim().isEmpty ? 'Please Enter Something to Post' : null,
    );
  }

  Widget _buildSenderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          InkWell(
            onTap: () {
              if (_key.currentState!.validate()) {
                context.read<PostsCubit>().repost(
                    postId: widget.postEntity.id,
                    content: _postController.text,
                    mediaUrls: mediaUrls,
                    taggedUserIds: taggedUserIds);
              }
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.color0xFF8338EC,
              child: component.assetImage(path: Assets.iconsSend),
            ),
          )
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
            postId: widget.postEntity.id,
            userIdEntity: widget.postEntity.userId,
            isMyPost: widget.postEntity.isMyPost,
            isFollowing: widget.postEntity.isFollowing,
          ),
          component.spacer(height: 10),
          component.text(
              DateFormat('d/M/y').format(widget.postEntity.updatedAt),
              style: theme.publicSansFonts.mediumStyle(
                fontColor: AppColors.neutral,
              )),
          component.spacer(height: 10),
          component.text(widget.postEntity.content,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 16,
                fontColor: AppColors.color0xFF1E293B,
              )),
          component.spacer(height: 16),
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
                    errorWidget:
                        component.assetImage(path: Assets.imagesDefaultAvatar),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return component.spacer(width: 10);
                },
                itemCount: widget.postEntity.mediaUrls.length,
              ),
            ),
          ],
          component.spacer(height: 12),
          const Divider(color: AppColors.color0xFFEAECF0, height: 0),
          component.spacer(height: 12),
          Row(
            children: [
              LikeDislikeButtonWidget(
                  isLiked: widget.postEntity.isLiked,
                  onTap: () {},
                  likeCount: widget.postEntity.totalLikes),
              component.spacer(width: 20),
              CommentButtonWidget(
                commentCount: widget.postEntity.totalComments,
                onTap: () {},
              ),
              const Spacer(),
              ShareButtonWidget(shareCount: widget.postEntity.totalShares),
            ],
          )
        ],
      ),
    );
  }
}
