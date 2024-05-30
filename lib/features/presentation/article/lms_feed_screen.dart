import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/presentation/article/create_or_edit_article_screen.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/article_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class LMSUserFeed extends StatefulWidget {
  const LMSUserFeed({super.key});

  @override
  State<LMSUserFeed> createState() => _LMSUserFeedState();
}

class _LMSUserFeedState extends State<LMSUserFeed> {
  List<ArticleEntity> articles = [];
  final ScrollController _scrollCtrl = ScrollController();
  int pagination = 1;
  int limit = 10;
  bool noMoreData = false;

  @override
  void initState() {
    _loadArticles();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent &&
          !noMoreData) {
        pagination += 1;
        _loadArticles();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleCubit, ArticleState>(
      listener: (context, state) {
        if (state is GetArticlesLoaded) {
          if (pagination == 1) {
            articles = state.articles;
          } else {
            articles.addAll(state.articles);
          }

          if (state.articles.length < limit) {
            noMoreData = true;
          }
        } else if (state is GetArticlesError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: Text(context.stringForKey(StringKeys.learningManagement)),
            centerTitle: true,
          ),
          body: ListView.builder(
            controller: _scrollCtrl,
            physics: const ScrollPhysics(),
            itemBuilder: (_, index) {
              return ArticleWidget(
                articleEntity: articles[index],
                onTap: () {
                  AiloitteNavigation.intentWithData(context,
                          AppRoutes.articleDetailRoute, articles[index].id)
                      .then((_) => _loadArticles());
                },
              );
            },
            itemCount: articles.length,
          ),
          floatingActionButton: UserHelper.role != UserRole.patient
              ? _buildCreateNewButton()
              : null,
        );
      },
    );
  }

  Widget _buildCreateNewButton() {
    return InkWell(
      onTap: () {
        AiloitteNavigation.intentWithData(
                context,
                AppRoutes.createOrEditArticleRoute,
                CreateOrEditScreenParams(isEditing: false, articleId: ''))
            .then((value) => _loadArticles());
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              component.assetImage(path: Assets.iconsPlusSign),
              component.spacer(width: 5),
              component.text(
                'Create New',
                style: theme.publicSansFonts
                    .semiBoldStyle(fontSize: 14, fontColor: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadArticles() {
    context
        .read<ArticleCubit>()
        .getArticles(pagination: pagination, limit: limit);
  }
}