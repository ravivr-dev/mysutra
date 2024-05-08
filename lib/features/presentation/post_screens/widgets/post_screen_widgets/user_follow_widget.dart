import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_entity.dart';
import '../../../../../ailoitte_component_injector.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/assets.dart';

class UserFollowWidget extends StatelessWidget {
  final VoidCallback? onShowMoreButtonClick;
  final UserIdEntity userIdEntity;
  final bool isMyPost;
  final bool isFollowing;

  const UserFollowWidget(
      {super.key,
      this.onShowMoreButtonClick,
      required this.userIdEntity,
      required this.isMyPost,
      required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(4),
          child: component.networkImage(
              url: userIdEntity.profilePic,
              height: 24,
              width: 24,
              fit: BoxFit.fill),
        ),
        component.spacer(width: 4),
        component.text(userIdEntity.fullName,
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 16,
            )),
        component.spacer(width: 4),
        if (userIdEntity.isVerified) ...[
          component.assetImage(
              path: Assets.iconsVerify,
              height: 20,
              width: 20,
              fit: BoxFit.fill),
        ],
        component.spacer(width: 3),
        if (!isMyPost) ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isFollowing ? AppColors.grey0xFFEAECF0 : AppColors.color0xFFEBE2FF,
            ),
            child: component.text(
                isFollowing
                    ? context.stringForKey(StringKeys.unfollow)
                    : context.stringForKey(StringKeys.follow),
                style: theme.publicSansFonts.mediumStyle(
                  fontColor: isFollowing
                      ? AppColors.color0xFF85799E
                      : AppColors.color0xFF8338EC,
                )),
          ),
        ],
        const Spacer(),
        InkWell(
          onTap: onShowMoreButtonClick,
          child: const Icon(
            Icons.more_vert,
            color: AppColors.color0xFF292D32,
            size: 18,
          ),
        )
      ],
    );
  }
}
