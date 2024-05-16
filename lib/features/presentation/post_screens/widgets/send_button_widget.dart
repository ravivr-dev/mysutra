import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class SendButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SendButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.color0xFF8338EC,
        child: component.assetImage(
          path: Assets.iconsSend,
          height: 20,
        ),
      ),
    );
  }
}
