import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();
  // bool _isKeyboardOpen = false;

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.close, color: AppColors.black01),
        title: component.text(context.stringForKey(StringKeys.createPost)),
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
                      Expanded(
                        child: _buildTextField(),
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
  }

  Widget _buildTextField() {
    return component.textField(
      controller: _postController,
      fillColor: AppColors.white,

      // onTapCallback: () => setState(() => _isKeyboardOpen = true),
      hintText: 'Enter Text Here...',
      borderRadius: 10,
      filled: true,
      focusedBorderColor: AppColors.color0xFFDADCE0,
      borderColor: AppColors.color0xFFDADCE0,
    );
  }

  Widget _buildSenderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                  color: AppColors.black01.withOpacity(.74),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        ImagePicker().pickImage(source: ImageSource.gallery);
                      },
                      child: component.assetImage(path: Assets.iconsImage)),
                  InkWell(
                      onTap: () =>
                          ImagePicker().pickVideo(source: ImageSource.gallery),
                      child: component.assetImage(path: Assets.iconsVideo)),
                  InkWell(
                      onTap: () {
                        //Navigate to document screen
                      },
                      child: component.assetImage(path: Assets.iconsDocs)),
                ],
              ),
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.color0xFF8338EC,
            child: component.assetImage(path: Assets.iconsSend),
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
          return _buildImage();
        },
        separatorBuilder: (_, __) {
          return component.spacer(width: 10);
        },
        itemCount: 5,
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(20),
          child: component.assetImage(
            path: Assets.iconsDummyDoctor,
            height: 153,
            width: 153,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.black01.withOpacity(.3),
            child: const Icon(Icons.close, color: AppColors.white),
          ),
        )
      ],
    );
  }
}
