import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/upload_image_bottomsheet.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_entity.dart';
import 'package:my_sutra/features/domain/entities/article_entities/article_media_urls_entity.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/article/widgets/save_button_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

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
          if (state.article.mediaUrls.isNotEmpty) {
            // _addImagesForEditing(state.article.mediaUrls);
            for (ArticleMediaUrlEntity e in state.article.mediaUrls) {
              imageList.add(e.url ?? '');
              mediaUrl.add(ArticleMediaUrlEntity(
                  mediaType: 'IMAGE_URL',
                  url: removeUntilLastSlash(e.url ?? '')));
            }
          }
        } else if (state is GetArticleDetailError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is UploadDocLoaded) {
          mediaUrl.add(ArticleMediaUrlEntity(
              mediaType: 'IMAGE_URL',
              url: removeUntilLastSlash(state.data.key ?? "")));

          imageList.add(state.data.fileUrl ?? '');

          // _bodyController.text += ' ${state.data.fileUrl} ';
        } else if (state is UploadDocError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is CreateArticleLoaded) {
          if (UserHelper.role == UserRole.doctor) {
            AiloitteNavigation.intentWithClearAllRoutesWithData(
                context, AppRoutes.homeRoute, 3);
          }
          if (UserHelper.role == UserRole.influencer) {
            AiloitteNavigation.intentWithClearAllRoutesWithData(
                context, AppRoutes.homeRoute, 1);
          }
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
                          content: _bodyController.text,
                          mediaUrls: mediaUrl,
                        );
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
                if (imageList.isNotEmpty) ...[
                  _buildImageWidget(),
                ],
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

  Widget _buildImageWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 153,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return _buildImage(index);
        },
        separatorBuilder: (_, __) {
          return component.spacer(width: 10);
        },
        itemCount: imageList.length,
      ),
    );
  }

  Widget _buildImage(int index) {
    return Stack(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(20),
          child: component.networkImage(
            url: imageList[index],
            // height: 153,
            // width: 153,
            fit: BoxFit.fitWidth,
            errorWidget: component.assetImage(path: Assets.imagesDefaultAvatar),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.black01.withOpacity(.3),
            child: Center(
              child: IconButton(
                  onPressed: () {
                    mediaUrl.remove(mediaUrl[index]);
                    imageList.remove(imageList[index]);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class CreateOrEditScreenParams {
  final bool isEditing;
  final String articleId;

  CreateOrEditScreenParams({required this.isEditing, required this.articleId});
}
