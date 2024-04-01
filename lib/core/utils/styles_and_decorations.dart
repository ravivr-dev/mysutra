import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class StylesAndDecorations {
  static BoxDecoration generalContainerDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: AppColors.neutral.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 3),
        ),
      ],
      color: AppColors.white,
    );
  }
}
