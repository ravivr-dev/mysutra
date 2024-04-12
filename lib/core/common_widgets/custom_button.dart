import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color? loaderColor;
  final String? text;
  final bool isLoading;
  final Color? textColor;
  final Color? buttonColor;
  final Function()? onPressed;
  final double? width;
  final String? icon;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleStyle;
  final double? borderRadius;

  const CustomButton({
    super.key,
    this.loaderColor,
    this.isLoading = false,
    this.text,
    this.textColor,
    this.buttonColor,
    this.onPressed,
    this.width,
    this.icon,
    this.titlePadding,
    this.titleStyle,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: isLoading ? nullPress : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          backgroundColor: buttonColor ?? AppColors.primaryColor,
        ),
        child: isLoading
            ? LoadingAnimationWidget.discreteCircle(
                color: loaderColor ?? AppColors.white,
                secondRingColor: AppColors.white.withOpacity(0.7),
                thirdRingColor: AppColors.white.withOpacity(0.3),
                size: 22,
              )
            : Padding(
                padding: titlePadding ??
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: component.text(
                  text ?? "",
                  style: titleStyle ??
                      theme.publicSansFonts.regularStyle(
                        fontSize: 18,
                        height: 22,
                        fontColor: textColor ?? AppColors.white,
                      ),
                ),
              ),
      ),
    );
  }

  void nullPress() {}
}
