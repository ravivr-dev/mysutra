import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/post_entities/post_user_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/follow_user_usecase.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/edit_or_delete_post_bottomsheet.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/view_profile_or_report_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';

class UserFollowWidget extends StatefulWidget {
  final String? postId;
  final PostUserEntity userIdEntity;
  final bool isMyPost;
  final bool isFollowing;
  final bool isPost;
  final Function(bool)? userFollowing;

  const UserFollowWidget(
      {super.key,
      required this.userIdEntity,
      required this.isMyPost,
      required this.isFollowing,
      this.postId,
      this.isPost = true,
      this.userFollowing});

  @override
  State<UserFollowWidget> createState() => _UserFollowWidgetState();
}

class _UserFollowWidgetState extends State<UserFollowWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchDoctorCubit, SearchDoctorState>(
      listener: (context, state) {
        if (state is FollowDoctorSuccessState) {
          widget.isFollowing != widget.isFollowing;
          widget.userFollowing?.call(widget.isFollowing);
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(4),
              child: component.networkImage(
                url: widget.userIdEntity.profilePic ?? '',
                height: 24,
                width: 24,
                fit: BoxFit.fill,
                errorWidget: component.assetImage(
                    path: Assets.imagesDefaultAvatar, fit: BoxFit.contain),
              ),
            ),
            component.spacer(width: 4),
            component.text(
                (widget.userIdEntity.fullName??'').isNotEmpty? widget.userIdEntity.fullName: widget.userIdEntity.username,
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                )),
            component.spacer(width: 4),
            if (widget.userIdEntity.isVerified) ...[
              component.assetImage(
                  path: Assets.iconsVerify,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill),
            ],
            component.spacer(width: 3),
            if (!widget.isMyPost &&
                (widget.userIdEntity.role == UserRole.doctor.name ||
                    widget.userIdEntity.role == UserRole.influencer.name)) ...[
              InkWell(
                onTap: () {
                  context.read<SearchDoctorCubit>().followDoctor(
                      params:
                          FollowUserParams(userId: widget.userIdEntity.id!));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: widget.isFollowing
                        ? AppColors.grey0xFFEAECF0
                        : AppColors.color0xFFEBE2FF,
                  ),
                  child: component.text(
                      widget.isFollowing
                          ? context.stringForKey(StringKeys.unfollow)
                          : context.stringForKey(StringKeys.follow),
                      style: theme.publicSansFonts.mediumStyle(
                        fontColor: widget.isFollowing
                            ? AppColors.color0xFF85799E
                            : AppColors.color0xFF8338EC,
                      )),
                ),
              ),
            ],
            if (widget.isPost) ...[
              const Spacer(),
              InkWell(
                onTap: () => context.showBottomSheet(widget.isMyPost
                    ? BlocProvider<PostsCubit>(
                        create: (context) => sl<PostsCubit>(),
                        child:
                            EditOrDeletePostBottomSheet(postId: widget.postId!),
                      )
                    : BlocProvider<SearchDoctorCubit>(
                        create: (context) => sl<SearchDoctorCubit>(),
                        child: ViewProfileOrReportBottomSheet(
                          postId: widget.postId!,
                          userId: widget.userIdEntity.id!,
                          userRole: widget.userIdEntity.role!,
                        ),
                      )),
                child: const Icon(
                  Icons.more_vert,
                  color: AppColors.color0xFF292D32,
                  size: 18,
                ),
              )
            ]
          ],
        );
      },
    );
  }
}
