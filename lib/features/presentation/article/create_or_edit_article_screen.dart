import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/upload_image_bottomsheet.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_media_urls_entity.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/save_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';

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
  final List<ArticleMediaUrlEntity> mediaUrl = [];
  final List<String> imageList = [];
  ArticleEntity? article;
  XFile? media;

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
        if (state is UploadDocLoaded) {
          mediaUrl.add(ArticleMediaUrlEntity(
              mediaType: 'IMAGE_URL',
              url: removeUntilLastSlash(state.data.key ?? "")));
          imageList.add(state.data.fileUrl!);
        } else if (state is UploadDocError) {
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
                          content: _bodyController.text,
                          mediaUrls: mediaUrl,
                        );
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
                _buildImageWidget(),
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
          floatingActionButton: _buildImageUploadButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
      },
    );
  }

  List<Widget> _processTextWithLinks(String text) {
    final urlRegex = RegExp(
      r'(?:(?:https?|ftp):\/\/[^\s/$.?#].[^\s]*)',
      caseSensitive: false,
    );
    final imageUrlRegex = RegExp(
      r'(?:(?:https?|ftp):\/\/[^\s/$.?#].[^\s]*\.(?:jpg|jpeg|png|gif))',
      caseSensitive: false,
    );

    List<Widget> widgets = [];
    final splitText = text.split(' ');

    for (var word in splitText) {
      if (imageUrlRegex.hasMatch(word)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.network(word),
          ),
        );
      } else if (urlRegex.hasMatch(word)) {
        widgets.add(
          GestureDetector(
            onTap: () => _launchURL(word),
            child: Text(
              word,
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        );
      } else {
        widgets.add(
          Text(word + ' '),
        );
      }
    }

    return widgets;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildImageUploadButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.black01.withOpacity(.74),
          borderRadius: BorderRadius.circular(25)),
      child: InkWell(
        onTap: () {
          updateImageSheet(onChange: (image) {
            if (image != null) {
              context.read<ArticleCubit>().uploadDoc(image);
              AiloitteNavigation.back(context);
            }
          });
        },
        child: component.assetImage(path: Assets.iconsImage),
      ),
    );
  }

  updateImageSheet({required dynamic Function(XFile?) onChange}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return UploadImageBottomSheet(
            showRemovePhoto: media != null,
            removePhoto: () {
              media = null;
              setState(() {});
              Navigator.pop(context);
            },
            onChange: onChange);
      },
    );
  }

  String removeUntilLastSlash(String url) {
    int lastSlashIndex = url.lastIndexOf('/');
    if (lastSlashIndex != -1 && lastSlashIndex + 1 < url.length) {
      return url.substring(lastSlashIndex + 1);
    }
    return url; // Return the original URL if no slash is found or if it's the last character
  }
}

class CreateOrEditScreenParams {
  final bool isEditing;
  final String articleId;

  CreateOrEditScreenParams({required this.isEditing, required this.articleId});
}
