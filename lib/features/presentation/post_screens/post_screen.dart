import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_screen_widgets/post_comment_widget.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_screen_widgets/user_follow_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: AppColors.backgroundColor,
        leading: Icon(Icons.arrow_back,
            color: AppColors.color0xFF00082F.withOpacity(.27)),
        title: component.text(context.stringForKey(StringKeys.post),
            style: theme.publicSansFonts.mediumStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPostWidget(),
            component.spacer(height: 12),
            _buildCommentWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildCommentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWriteYourCommentWidget(),
          component.spacer(height: 16),
          _buildDivider(),
          component.spacer(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: component.text(context.stringForKey(StringKeys.comments),
                style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
          ),
          component.spacer(height: 16),
          _buildComments()
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0, height: 0);
  }

  Widget _buildComments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const PostCommentWidget(),
          component.spacer(height: 14),
          _buildDivider(),
          component.spacer(height: 14),
          const PostCommentWidget()
        ],
      ),
    );
  }

  Widget _buildWriteYourCommentWidget() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(color: AppColors.greyD9)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: component.textField(
                  controller: _commentController,
                  contentPadding: EdgeInsets.zero,
                  hintText: context.stringForKey(StringKeys.writeYourComment),
                  hintTextStyle: theme.publicSansFonts
                      .regularStyle(fontSize: 16, fontColor: AppColors.black81),
                  borderColor: AppColors.transparent)),
          CircleAvatar(
            backgroundColor: AppColors.color0xFF8338EC,
            child: component.assetImage(path: Assets.iconsSend),
          )
        ],
      ),
    );
  }

  Widget _buildPostWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.color0xFFE2E8F0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserFollowWidget(showMoreButton: true),
          component.spacer(height: 10),
          component.text('5h ago',
              style: theme.publicSansFonts.mediumStyle(
                fontColor: AppColors.neutral,
              )),
          component.spacer(height: 10),
          component.text(
              'Lorem ipsum dolor sit amet consectetur. Euismod lorem sed massa sociis. Porttitor tempor ut viverra tempor nulla tincidunt odio tristique quis. Vel hendrerit tincidunt diam non dignissim netus ut. Amet egestas risus nulla vel magna semper. Ac in nibh tempus.',
              style: theme.publicSansFonts.regularStyle(
                fontSize: 16,
                fontColor: AppColors.color0xFF1E293B,
              )),
          component.spacer(height: 16),
          component.assetImage(path: Assets.iconsDummyDoctor),
          component.spacer(height: 12),
          _buildDivider(),
          component.spacer(height: 12),
          Row(
            children: [
              component.assetImage(path: Assets.iconsHeart),
              component.spacer(width: 4),
              component.text('2.5k',
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 12, fontColor: AppColors.color0xFF111111)),
              component.spacer(width: 20),
              component.assetImage(path: Assets.iconsComment),
              component.spacer(width: 4),
              component.text('100',
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 12, fontColor: AppColors.color0xFF111111)),
              const Spacer(),
              component.assetImage(path: Assets.iconsShare),
              component.spacer(width: 4),
              component.text('20',
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 12, fontColor: AppColors.color0xFF111111)),
            ],
          )
        ],
      ),
    );
  }
}
