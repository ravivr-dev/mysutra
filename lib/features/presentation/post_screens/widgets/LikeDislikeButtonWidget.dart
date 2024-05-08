import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class LikeDislikeButtonWidget extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const LikeDislikeButtonWidget(
      {super.key, required this.isLiked, required this.onTap});

  @override
  State<LikeDislikeButtonWidget> createState() =>
      _LikeDislikeButtonWidgetState();
}

class _LikeDislikeButtonWidgetState extends State<LikeDislikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 17,
      child: InkWell(
        onTap: widget.onTap,
        child: component.assetImage(
            path: Assets.iconsHeart,
            color: widget.isLiked ? Colors.red : AppColors.grey92),
      ),
    );
  }
}
