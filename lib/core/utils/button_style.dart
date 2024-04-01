import 'package:flutter/cupertino.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class ButtonStyle {
  static getFilledButton({
    final double radius = 100,
    final Color buttonColor = AppColors.primaryColor,
  }) {
    return BoxDecoration(
      color: buttonColor,
    );
  }

  static const BoxDecoration decoration = BoxDecoration();
}
