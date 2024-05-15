import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/reporting_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ViewProfileOrReportBottomSheet extends StatelessWidget {
  final String userId;
  final String postId;

  const ViewProfileOrReportBottomSheet(
      {super.key, required this.postId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchDoctorCubit, SearchDoctorState>(
      listener: (context, state) {
        if (state is GetDoctorDetailsSuccessState) {
          _navigateToDoctorDetailScreen(
              context: context, entity: state.doctorEntity);
        }
      },
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            _buildRow(context, onTap: () {
              Navigator.pop(context);
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

  void _navigateToDoctorDetailScreen(
      {required BuildContext context, required DoctorEntity entity}) {
    Navigator.pushNamed(context, AppRoutes.doctorDetail, arguments: entity);
  }

  void _getDoctorDetails(
      {required BuildContext context, required String doctorId}) {
    context.read<SearchDoctorCubit>().getDoctorDetails(doctorId: doctorId);
  }
}
