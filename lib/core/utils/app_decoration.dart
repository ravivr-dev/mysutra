import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class AppDeco {
  static const EdgeInsetsGeometry screenPadding =
      EdgeInsets.symmetric(horizontal: 22);

  static BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: AppColors.white,
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 5,
          offset: const Offset(5, 5)),
      BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 5,
          offset: const Offset(-1, 1)),
    ],
  );

  static SafeArea screenTopHandler = const SafeArea(child: SizedBox.shrink());
}
