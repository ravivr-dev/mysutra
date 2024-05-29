import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/save_button_widget.dart';

class CreateArticleScreen extends StatefulWidget {
  final CreateOrEditScreenParams params;

  const CreateArticleScreen({super.key, required this.params});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  ArticleEntity? article;

  @override
  void initState() {
    if (widget.params.isEditing) {
      context
          .read<ArticleCubit>()
          .getArticleDetail(articleId: widget.params.articleId);
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleCubit, ArticleState>(
      listener: (context, state) {
        if (state is GetArticleDetailLoaded) {
          _bodyController.text = state.article.content ?? '';
          _titleController.text = state.article.heading ?? '';
        } else if (state is GetArticleDetailError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is CreateArticleLoaded) {
          AiloitteNavigation.back(context);
        } else if (state is CreateArticleError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is EditArticleLoaded) {
          AiloitteNavigation.back(context);
        } else if (state is CreateArticleError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.stringForKey(StringKeys.articleName),
              style: theme.publicSansFonts
                  .regularStyle(fontColor: AppColors.grey92, fontSize: 20),
            ),
            centerTitle: true,
            actions: [
              SaveButtonWidget(onTap: () {
                if (_key.currentState!.validate()) {
                  if (widget.params.isEditing) {
                    context.read<ArticleCubit>().editArticle(
                        articleId: widget.params.articleId,
                        heading: _titleController.text,
                        content: _bodyController.text);
                  } else {
                    context.read<ArticleCubit>().createPost(
                        heading: _titleController.text,
                        content: _bodyController.text);
                  }
                }
              }),
            ],
          ),
          body: Form(
            key: _key,
            child: ListView(
              children: [
                component.textField(
                  controller: _titleController,
                  hintText: 'Title Name',
                  hintTextStyle: theme.publicSansFonts
                      .regularStyle(fontSize: 20, fontColor: AppColors.greyD9),
                  filled: true,
                  borderColor: AppColors.white,
                  validator: (val) {
                    return val!.trim().isEmpty
                        ? 'Please enter Heading of the article'
                        : null;
                  },
                ),
                component.textField(
                  controller: _bodyController,
                  hintText: 'Note',
                  hintTextStyle: theme.publicSansFonts
                      .regularStyle(fontSize: 16, fontColor: AppColors.greyD9),
                  filled: true,
                  borderColor: AppColors.white,
                  validator: (val) {
                    return val!.trim().isEmpty
                        ? 'Please enter Body of the Article'
                        : null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CreateOrEditScreenParams {
  final bool isEditing;
  final String articleId;

  CreateOrEditScreenParams({required this.isEditing, required this.articleId});
}
