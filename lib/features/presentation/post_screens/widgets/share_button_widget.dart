import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class ShareButtonWidget extends StatelessWidget {
  final int shareCount;
  final VoidCallback? onTap;

  const ShareButtonWidget({super.key, required this.shareCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        height: 20,
        child: Row(
          children: [
            component.assetImage(
                path: Assets.iconsShare, color: AppColors.grey92),
            component.spacer(width: 4),
            component.text('$shareCount',
                style: theme.publicSansFonts.mediumStyle(
                    fontSize: 12, fontColor: AppColors.color0xFF111111)),
          ],
        ),
      ),
    );
  }
}
