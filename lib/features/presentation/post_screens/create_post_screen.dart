import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/upload_image_bottomsheet.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/media_urls_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class CreatePostScreen extends StatefulWidget {
  final bool isEditing;
  final String postId;

  const CreatePostScreen({super.key, this.isEditing = false, this.postId = ''});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();
  final List<MediaUrlEntity> mediaUrls = [];
  final List<String> imageList = [];
  final List<String> taggedUserIds = [];
  XFile? media;

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
        if (state is UploadDocument) {
          mediaUrls.add(
              MediaUrlEntity(mediaType: 'IMAGE_URL', url: state.data.key!));
          imageList.add(state.data.fileUrl!);
        } else if (state is UploadDocumentError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is CreatePostLoaded) {
          // widget.showSuccessToast(context: context, message: state.message);
          AiloitteNavigation.intentWithClearAllRoutesWithData(
              context, AppRoutes.homeRoute, 1);
        } else if (state is CreatePostError) {
          widget.showErrorToast(context: context, message: state.error);
        }
        if (state is EditPostLoaded) {
          AiloitteNavigation.intentWithClearAllRoutes(
              context, AppRoutes.homeRoute);
        } else if (state is EditPostError) {
          widget.showErrorToast(context: context, message: state.error);
        }

        if (state is GetPostDetailLoaded) {
          _postController.text = state.post.content;
          if (state.post.mediaUrls.isNotEmpty) {
            state.post.mediaUrls.map((e) => imageList.add(e.url ?? ''));
          }
          if (state.post.taggedUserIds.isNotEmpty) {
            state.post.taggedUserIds.map((e) => taggedUserIds.add(e));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  AiloitteNavigation.intentWithClearAllRoutes(
                      context, AppRoutes.homeRoute);
                },
                icon: const Icon(Icons.close, color: AppColors.black01)),
            title: widget.isEditing
                ? component.text(context.stringForKey(StringKeys.editPost))
                : component.text(context.stringForKey(StringKeys.createPost)),
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
                      _buildImageWidget()
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
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                  color: AppColors.black01.withOpacity(.74),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // ImagePicker().pickImage(source: ImageSource.gallery);
                      updateImageSheet(onChange: (image) {
                        if (image != null) {
                          context.read<PostsCubit>().uploadDoc(image);
                          AiloitteNavigation.back(context);
                        }
                      });
                    },
                    child: component.assetImage(path: Assets.iconsImage),
                  ),
                  // InkWell(
                  //     onTap: () =>
                  //         ImagePicker().pickVideo(source: ImageSource.gallery),
                  //     child: component.assetImage(path: Assets.iconsVideo)),
                  InkWell(
                    onTap: () {
                      //Navigate to document screen
                    },
                    child: component.assetImage(path: Assets.iconsDocs),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (_key.currentState!.validate()) {
                if (widget.isEditing) {
                  context.read<PostsCubit>().editPost(
                      postId: widget.postId,
                      content: _postController.text,
                      mediaUrls: mediaUrls,
                      taggedUserIds: taggedUserIds);
                } else {
                  context.read<PostsCubit>().createPost(
                      content: _postController.text,
                      mediaUrls: mediaUrls,
                      taggedUserIds: taggedUserIds);
                }
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

  Widget _buildImageWidget() {
    return SizedBox(
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
            height: 153,
            width: 153,
            fit: BoxFit.fill,
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
                    mediaUrls.remove(mediaUrls[index]);
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
}
