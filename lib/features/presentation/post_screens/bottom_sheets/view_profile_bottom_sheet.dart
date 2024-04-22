import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/post_screens/bottom_sheets/reporting_bottom_sheet.dart';
import 'package:my_sutra/generated/assets.dart';

class ViewProfileBottomSheet extends StatelessWidget {
  const ViewProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(context,
              key: StringKeys.viewProfile, icon: Assets.iconsWarning),
          const Divider(color: AppColors.color0xFFEAECF0),
          _buildRow(
            context,
            onTap: () {
              Navigator.pop(context);
              context.showBottomSheet(
                const ReportingBottomSheet(),
                isScrollControlled: true,
              );
            },
            key: StringKeys.report,
            icon: Assets.iconsReport,
            fontColor: AppColors.color0xFFF34848,
          )
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String key,
    required String icon,
    Color? fontColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          component.assetImage(path: icon),
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
