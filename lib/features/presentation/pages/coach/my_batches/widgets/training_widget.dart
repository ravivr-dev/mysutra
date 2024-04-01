import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/generated/assets.dart';

class TrainingCard extends StatelessWidget {
  final TrainingProgram data;
  const TrainingCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 10, top: 2),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(.16),
              borderRadius: BorderRadius.circular(6),
            ),
            child: component.assetImage(path: Assets.iconsSchedule),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? "Unknown",
                  style: theme.publicSansFonts.regularStyle(
                      fontSize: 16, fontColor: AppColors.neutralAlpha),
                ),
                Text(
                  data.date != null
                      ? DateFormat('hh:mm a').format(data.date!)
                      : "",
                  style: theme.publicSansFonts.regularStyle(
                      fontSize: 14, height: 24, fontColor: AppColors.black49),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TainingItem {
  final String title;
  final String time;

  TainingItem({
    required this.title,
    required this.time,
  });
}
