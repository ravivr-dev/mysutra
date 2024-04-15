import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import '../../../../../ailoitte_component_injector.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/assets.dart';

class UserFollowWidget extends StatelessWidget {
  final bool showMoreButton;

  const UserFollowWidget({this.showMoreButton = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(4),
          child: component.assetImage(
              path: Assets.iconsDummyDoctor,
              height: 24,
              width: 24,
              fit: BoxFit.fill),
        ),
        component.spacer(width: 4),
        component.text('Rita Agarwal',
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 16,
            )),
        component.spacer(width: 4),
        component.assetImage(
            path: Assets.iconsVerify, height: 20, width: 20, fit: BoxFit.fill),
        component.spacer(width: 3),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: AppColors.color0xFFEBE2FF,
          ),
          child: component.text(context.stringForKey(StringKeys.follow),
              style: theme.publicSansFonts.mediumStyle(
                fontColor: AppColors.color0xFF8338EC,
              )),
        ),
        const Spacer(),
        if (showMoreButton)
          const Icon(
            Icons.more_vert,
            color: AppColors.color0xFF292D32,
            size: 18,
          )
      ],
    );
  }
}
