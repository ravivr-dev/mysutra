import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class ReportingBottomSheet extends StatelessWidget {
  const ReportingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading(),
          component.spacer(height: 20),
          _buildTextWidget(value: 'I just don\'t like it'),
          component.spacer(height: 10),
          _buildDivider(),
          _buildTextWidget(value: 'Fraud or scam'),
          component.spacer(height: 10),
          _buildDivider(),
          _buildTextWidget(value: 'Drugs'),
          component.spacer(height: 10),
          _buildDivider(),
          _buildTextWidget(value: 'Something else'),
          component.spacer(height: 10),
          _buildDivider(),
          _buildTextWidget(value: 'False information'),
          component.spacer(height: 10),
          _buildDivider(),
          _buildTextWidget(value: 'Nudity or sexual activity'),
          component.spacer(height: 10),
          _buildDivider(),
          _buildTextWidget(value: 'Something else'),
          component.spacer(height: 10),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0);
  }

  Widget _buildTextWidget({required String value}) {
    return component.text(
      value,
      style: theme.publicSansFonts.regularStyle(
        fontSize: 16,
        fontColor: AppColors.color0xFF1E293B,
      ),
    );
  }

  Widget _buildHeading() {
    return component.text(
      'Why are you reporting this post?',
      style: theme.publicSansFonts.semiBoldStyle(
        fontSize: 18,
        fontColor: AppColors.color0xFF1E293B,
      ),
    );
  }
}
