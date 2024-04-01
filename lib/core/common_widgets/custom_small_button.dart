import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class CustomSmallButton extends StatelessWidget {
  final Color? loaderColor;
  final String? text;
  final bool? isLoading;
  final Color? textColor;
  final Color? buttonColor;
  final Function()? onPressed;
  final double? width;
  final String? icon;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleStyle;
  const CustomSmallButton({
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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading! ? nullPress : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: buttonColor ?? AppColors.primaryColor,
        ),
        child: isLoading!
            ? LoadingAnimationWidget.inkDrop(
                color: loaderColor ?? AppColors.white,
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
