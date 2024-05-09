import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class LikeDislikeButtonWidget extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;
  final int likeCount;

  const LikeDislikeButtonWidget(
      {super.key,
      required this.isLiked,
      required this.onTap,
      required this.likeCount});

  @override
  State<LikeDislikeButtonWidget> createState() =>
      _LikeDislikeButtonWidgetState();
}

class _LikeDislikeButtonWidgetState extends State<LikeDislikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: 20,
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          children: [
            component.assetImage(
                path: Assets.iconsHeart,
                color: widget.isLiked ? Colors.red : AppColors.grey92),
            component.spacer(width: 4),
            component.text('${widget.likeCount}',
                style: theme.publicSansFonts.mediumStyle(
                    fontSize: 12, fontColor: AppColors.color0xFF111111)),
          ],
        ),
      ),
    );
  }
}
