import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import 'package:my_sutra/features/presentation/post_screens/widgets/post_screen_widgets/user_follow_widget.dart';

class PostWidget extends StatelessWidget {
  final PostEntity postEntity;

  const PostWidget({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          component.text(
            DateFormat('d/M/y').format(postEntity.updatedAt.toLocal()),
            style: theme.publicSansFonts.mediumStyle(
              fontColor: AppColors.neutral,
            ),
          ),
          component.text(postEntity.content,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 16,
                fontColor: AppColors.color0xFF1E293B,
              )),
        ],
      ),
    );
  }
}
