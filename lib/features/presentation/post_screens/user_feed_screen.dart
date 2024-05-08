import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  List<PostEntity> posts = [];

  @override
  void initState() {
    context.read<PostsCubit>().getPosts(pagination: 1, limit: 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is GetPostsLoaded) {
          posts = state.posts;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            top: true,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderWidget(),
                    component.spacer(height: 23),
                    if (posts.isNotEmpty) ...[
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PostWidget(postEntity: posts[index]);
                          },
                          separatorBuilder: (_, index) {
                            return component.spacer(height: 15);
                          },
                          itemCount: posts.length)
                    ] else ...[
                      component.text('No Posts Here',
                          style: theme.publicSansFonts.mediumStyle(
                              fontSize: 25, fontColor: AppColors.grey92)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderWidget() {
    return Row(
      children: [
        component.assetImage(
          path: Assets.iconsLogo1,
          height: 40,
          width: 100,
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
