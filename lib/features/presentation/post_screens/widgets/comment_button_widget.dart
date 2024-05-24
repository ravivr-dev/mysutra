import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class CommentButtonWidget extends StatelessWidget {
  final int commentCount;
  final VoidCallback onTap;

  const CommentButtonWidget({
    super.key,
    required this.commentCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: 20,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Row(children: [
          component.assetImage(
              path: Assets.iconsComment, color: AppColors.grey92),
          component.spacer(width: 4),
          component.text('$commentCount',
              style: theme.publicSansFonts.mediumStyle(
                  fontSize: 12, fontColor: AppColors.color0xFF111111)),
        ]),
      ),
    );
  }
}
