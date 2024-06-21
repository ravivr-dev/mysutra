import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/reporting_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ViewProfileOrReportBottomSheet extends StatelessWidget {
  final String userId;
  final String postId;
  final String userRole;
  final Function() refresh;

  const ViewProfileOrReportBottomSheet({
    super.key,
    required this.postId,
    required this.userId,
    required this.userRole,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchDoctorCubit, SearchDoctorState>(
      listener: (_, state) async {
        if (state is GetDoctorDetailsSuccessState) {
          await Navigator.pushNamed(context, AppRoutes.doctorDetail,
              arguments: state.doctorEntity);
          refresh.call();
          if (context.mounted) {
            AiloitteNavigation.back(context);
          }
        }
      },
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (userRole == 'DOCTOR') ...[
              _buildRow(
                context,
                onTap: () {
                  context
                      .read<SearchDoctorCubit>()
                      .getDoctorDetails(doctorId: userId);
                },
                key: StringKeys.viewProfile,
                icon: Assets.iconsReport,
                color: AppColors.black24,
              ),
              const Divider(color: AppColors.color0xFFEAECF0),
            ],
            _buildRow(context, onTap: () {
              context.showBottomSheet(
                BlocProvider(
                  create: (context) => sl<PostsCubit>(),
                  child: ReportingBottomSheet(
                    postId: postId,
                  ),
                ),
                isScrollControlled: true,
              );
            },
                key: StringKeys.report,
                icon: Assets.iconsWarning,
                fontColor: AppColors.color0xFFF34848,
                color: AppColors.error)
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String key,
    required String icon,
    required Color color,
    Color? fontColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          component.assetImage(path: icon, color: color),
          component.spacer(width: 8),
          component.text(context.stringForKey(key),
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  fontColor: fontColor ?? AppColors.color0xFF1E293B))
        ],
      ),
    );
  }
}
