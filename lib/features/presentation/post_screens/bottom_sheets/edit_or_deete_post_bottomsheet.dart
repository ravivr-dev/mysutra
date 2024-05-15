import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/reporting_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';

class EditOrDeletePostBottomSheet extends StatelessWidget {
  final String postId;

  const EditOrDeletePostBottomSheet({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(context,
              key: 'Edit Post', icon: Assets.iconsReport, color: Colors.black),
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
              key: 'Delete Post',
              icon: Assets.iconsWarning,
              fontColor: AppColors.color0xFFF34848,
              color: Colors.black)
        ],
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
          component.text(key,
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  fontColor: fontColor ?? AppColors.color0xFF1E293B))
        ],
      ),
    );
  }
}
