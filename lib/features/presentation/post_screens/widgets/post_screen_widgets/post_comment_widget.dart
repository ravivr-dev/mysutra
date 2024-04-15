import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_screen_widgets/user_follow_widget.dart';
import '../../../../../ailoitte_component_injector.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/assets.dart';

class PostCommentWidget extends StatelessWidget {
  const PostCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.color0xFFE2E8F0),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommentWidget(context),
          component.spacer(height: 16),
          const Divider(color: AppColors.color0xFFEAECF0),
          component.spacer(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: _buildCommentWidget(context, showReplyText: false),
          )
        ],
      ),
    );
  }

  Widget _buildCommentWidget(BuildContext context,
      {bool showReplyText = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserFollowWidget(),
        component.spacer(height: 10),
        component.text('5h ago',
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.neutral,
            )),
        component.spacer(height: 8),
        component.text(
          'Lorem ipsum dolor sit amet consectetur. Euismod lorem sed massa sociis. Porttitor tempor ut viverra tempor nulla tincidunt odio tristique quis. Vel hendrerit tincidunt diam non dignissim netus ut. Amet egestas risus nulla vel magna semper. Ac in nibh tempus.',
          style: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF1E293B,
          ),
        ),
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
            if (showReplyText)
              component.text(context.stringForKey(StringKeys.reply),
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 16, fontColor: AppColors.primaryColor)),
          ],
        ),
      ],
    );
  }
}
