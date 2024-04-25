import 'package:flutter/material.dart';
import '../../ailoitte_component_injector.dart';
import '../../generated/assets.dart';
import '../utils/app_colors.dart';

class TimeContainer extends StatelessWidget {
  final String? time;

  const TimeContainer({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: AppColors.color0xFFF1F5F9,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          component.assetImage(path: Assets.iconsClock),
          component.spacer(width: 4),
          component.text(time),
        ],
      ),
    );
  }
}
