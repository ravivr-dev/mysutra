import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  List<PostEntity> posts = [];
  final ScrollController _scrollCtrl = ScrollController();
  final RefreshController _refCtrl = RefreshController();
  int pagination = 1;
  bool noMoreData = false;
  int limit = 10;

  @override
  void initState() {
    _loadPosts();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent &&
          !noMoreData) {
        pagination += 1;
        _loadPosts();
      }
    });
    super.initState();
  }

  void _refresherControls() {
    if (_refCtrl.isLoading) {
      _refCtrl.loadComplete();
    }
    if (_refCtrl.isRefresh) {
      _refCtrl.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is GetPostsLoaded) {
          if (pagination == 1) {
            _refresherControls();
            posts = state.posts;
          } else {
            posts.addAll(state.posts);
          }
          if (state.posts.length < limit) {
            noMoreData = true;
          }
        } else if (state is GetPostsError) {
          widget.showErrorToast(context: context, message: state.error);
        }

        if (state is DeletePostLoaded) {
          _loadPosts();
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
              child: SmartRefresher(
                controller: _refCtrl,
                onRefresh: _loadPosts,
                child: SingleChildScrollView(
                  controller: _scrollCtrl,
                  child: Column(
                    children: [
                      _buildHeaderWidget(),
                      component.spacer(height: 23),
                      if (state is GetPostsLoading && posts.isEmpty)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (posts.isNotEmpty) ...[
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return PostWidget(
                                postEntity: posts[index],
                                onTapShare: () {
                                  AiloitteNavigation.intentWithData(context,
                                          AppRoutes.repostRoute, posts[index])
                                      .then((_) => _loadPosts());
                                },
                              );
                            },
                            itemCount: posts.length)
                      ] else
                        component.text('No Posts Here',
                            style: theme.publicSansFonts.mediumStyle(
                                fontSize: 25, fontColor: AppColors.grey92)),
                    ],
                  ),
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

  void _loadPosts() {
    context.read<PostsCubit>().getPosts(pagination: pagination, limit: limit);
  }
}
