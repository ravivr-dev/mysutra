import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/edit_or_deete_post_bottomsheet.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/view_profile_or_report_bottom_sheet.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class UserFollowWidget extends StatelessWidget {
  final String? postId;
  final PostUserEntity userIdEntity;
  final bool isMyPost;
  final bool isFollowing;
  final bool isPost;

  const UserFollowWidget(
      {super.key,
      required this.userIdEntity,
      required this.isMyPost,
      required this.isFollowing,
      this.postId,
      this.isPost = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(4),
          child: component.networkImage(
            url: userIdEntity.profilePic ?? '',
            height: 24,
            width: 24,
            fit: BoxFit.fill,
            errorWidget: component.assetImage(
                path: Assets.imagesDefaultAvatar, fit: BoxFit.contain),
          ),
        ),
        component.spacer(width: 4),
        component.text(userIdEntity.username,
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
        if (!isMyPost && userIdEntity.role == 'DOCTOR') ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isFollowing
                  ? AppColors.grey0xFFEAECF0
                  : AppColors.color0xFFEBE2FF,
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
          onTap: () => context.showBottomSheet(isMyPost
              ? EditOrDeletePostBottomSheet(postId: postId!)
              : BlocProvider<SearchDoctorCubit>(
                  create: (context) => sl<SearchDoctorCubit>(),
                  child: ViewProfileOrReportBottomSheet(
                    postId: postId!,
                    userId: userIdEntity.id!,
                    userRole: userIdEntity.role!,
                  ),
                )),
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
