import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/save_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
        if (state is CreateArticleLoaded) {
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
                  context.read<ArticleCubit>().createPost(
                      heading: _titleController.text,
                      content: _bodyController.text);
                }
                _titleController.clear();
                _bodyController.clear();
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
          floatingActionButton: _buildFooter(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.color0xFFF1F5F9,
      ),
      child: InkWell(
        onTap: () {},
        child: component.assetImage(path: Assets.iconsAddSquare),
      ),
    );
  }
}
