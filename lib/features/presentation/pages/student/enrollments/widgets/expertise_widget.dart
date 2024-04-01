import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class ExpertiseWidget extends StatelessWidget {
  const ExpertiseWidget({super.key, required this.expertiseName});

  final String expertiseName;

  Color get color => expertiseName == 'Batting'
      ? AppColors.blue25
      : expertiseName == 'Bowling'
          ? AppColors.colorFF9F12
          : expertiseName == 'Fielding'
              ? AppColors.color56CA7E
              : AppColors.grey92;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Text(
          expertiseName,
          style: theme.publicSansFonts
              .semiBoldStyle(fontColor: color, fontSize: 13),
        ),
      ),
    );
  }
}
