import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';

class BatchCard extends StatelessWidget {
  final BatchItem data;
  const BatchCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data.name}  (${DateFormat('hh:mm a').format(data.startTime!)} - ${DateFormat('hh:mm a').format(data.endTime!)})",
            style: theme.publicSansFonts.regularStyle(
                fontSize: 16, height: 24, fontColor: AppColors.neutralAlpha),
          ),
          Text(
            "${data.students} Students",
            style: theme.publicSansFonts.regularStyle(
                fontSize: 14, height: 24, fontColor: AppColors.black49),
          ),
        ],
      ),
    );
  }
}
