import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

const String appFontArial = 'Arial';
const double fontSize42 = 42;
const double fontSize18 = 18;
const double fontSize14 = 14;
const double defaultHeight1_2 = 1.2;
const double defaultLetterSpacingPoint5 = .5;
const double defaultWordSpacingPoint3 = .3;

class ArialComponentFonts extends AiloitteFonts {
  static double? defaultFontSize = 14;
  static double? defaultLetterSpacing;
  static double? defaultWordSpacing;
  static double? defaultHeight;
  static String? defaultFontType = appFontArial;
  static Color defaultFontColor = AppColors.blackColor;
  static TextDecoration? defaultDecoration;
  static Color? defaultBackgroundColor;

  @override
  TextStyle thinStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
    final Paint? foreground,
  }) {
    return customStyle(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w300,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      decoration: decoration,
      fontType: fontType ?? appFontArial,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      foreground: foreground,
    );
  }

  @override
  TextStyle regularStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
    final Paint? foreground,
  }) {
    return customStyle(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w400,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      decoration: decoration,
      fontType: fontType ?? appFontArial,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      foreground: foreground,
    );
  }

  @override
  TextStyle mediumStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
    final Paint? foreground,
  }) {
    return customStyle(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w500,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      decoration: decoration,
      fontType: fontType ?? appFontArial,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      foreground: foreground,
    );
  }

  @override
  TextStyle semiBoldStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
    final Paint? foreground,
  }) {
    return customStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      decoration: decoration,
      fontType: fontType ?? appFontArial,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      foreground: foreground,
    );
  }

  @override
  TextStyle boldStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
    final Paint? foreground,
  }) {
    return customStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w700,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      decoration: decoration,
      fontType: fontType ?? appFontArial,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      foreground: foreground,
    );
  }
}
