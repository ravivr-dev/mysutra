import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

const String appFontInter = 'Inter';


class ComponentFonts extends AiloitteFonts {
  ComponentFonts({
    this.defaultFontColor = AppColors.blackColor,
  }) : super(
          defaultFontSize: defaultFontSize,
          defaultLetterSpacing: defaultLetterSpacing,
          defaultWordSpacing: defaultWordSpacing,
          defaultHeight: defaultHeight,
          defaultFontType: defaultFontType,
          defaultFontColor: defaultFontColor,
          defaultDecoration: defaultDecoration,
          defaultBackgroundColor: defaultBackgroundColor,
        );

  @override
  ComponentFonts copyWith({
    double? defaultFontSize,
    double? defaultLetterSpacing,
    double? defaultWordSpacing,
    double? defaultHeight,
    String? defaultFontType,
    Color? defaultFontColor,
    TextDecoration? defaultDecoration,
    Color? defaultBackgroundColor,
  }) =>
      ComponentFonts(
        defaultFontColor: defaultFontColor ??  AppColors.blackColor,

      );
  static double? defaultFontSize = 14;
  static double? defaultLetterSpacing = 1.2;
  static double? defaultWordSpacing;
  static double? defaultHeight;
  static String? defaultFontType = appFontInter;
  final Color defaultFontColor;
  static TextDecoration? defaultDecoration;
  static Color? defaultBackgroundColor;

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
  }) {
    return customStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
      fontColor: fontColor,
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
      fontSize: fontSize ?? 24,
      fontWeight: FontWeight.w700,
      fontColor: fontColor,
    );
  }

  @override
  TextStyle extraBoldStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
  }) {
    return customStyle(
      fontSize: fontSize ?? 24,
      fontWeight: FontWeight.w800,
      fontColor: fontColor,
    );
  }

  @override
  TextStyle blackStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontType,
    final Color? fontColor,
    final FontWeight? fontWeight,
    final TextDecoration? decoration,
    final Color? backgroundColor,
  }) {
    return customStyle(
      fontSize: fontSize ?? 24,
      fontWeight: FontWeight.w900,
      fontColor: fontColor,
    );
  }

  TextStyle headingStyleApp({
    final double fontSize = fontSize42,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double? wordHeight,
    final String fontType = appFontInter,
    final Color? fontColor,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontHeight: wordHeight,
      fontType: fontType,
      fontColor: fontColor ?? defaultFontColor,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle subHeadingStyleApp({
    final double fontSize = fontSize18,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double? fontHeight,
    final String fontType = appFontInter,
    final Color? fontColor,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontHeight: fontHeight,
      fontType: fontType,
      fontColor: fontColor ?? defaultFontColor,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle regularStyleApp({
    final double fontSize = fontSize14,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double? fontHeight, //17
    final String fontType = appFontInter,
    final Color? fontColor,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontHeight: fontHeight,
      fontType: fontType,
      fontColor: fontColor ?? defaultFontColor,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle mediumStyleApp({
    final double fontSize = fontSize14,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double? fontHeight,
    final String fontType = appFontInter,
    final Color? fontColor,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontHeight: fontHeight,
      fontType: fontType,
      fontColor: fontColor ?? defaultFontColor,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle boldStyleApp({
    final double fontSize = fontSize14,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double? wordHeight,
    final String fontType = appFontInter,
    final Color fontColor = AppColors.blackColor,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontHeight: wordHeight,
      fontType: fontType,
      fontColor: fontColor,
      fontWeight: FontWeight.w700,
    );
  }

  /// WordHeight and FontHeight are same
  /// Equal to Height of text which is descriptive in Design
  TextStyle extraBoldStyleApp({
    final double fontSize = fontSize14,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double? fontHeight,
    final String fontType = appFontInter,
    final Color fontColor = AppColors.blackColor,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontHeight: fontHeight,
      fontType: fontType,
      fontColor: fontColor,
      fontWeight: FontWeight.w800,
    );
  }

  // thin 300
  // regular 400
  // medium 500
  // semiBold 600
  // bold 700
  // extraBold 800
  // black 900

  TextStyle customStyleApp({
    final double fontSize = fontSize14,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double height = defaultHeight1_2,
    final double? fontHeight,
    final String fontType = appFontInter,
    final Color fontColor = AppColors.blackColor,
    final FontWeight fontWeight = FontWeight.w500,
    final TextDecoration decoration = TextDecoration.none,
    final Color backgroundColor = Colors.transparent,
  }) {
    return _getAppTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontType: fontType,
      fontColor: fontColor,
      fontWeight: fontWeight,
      decoration: decoration,
      backgroundColor: backgroundColor,
    );
  }

  TextStyle _getAppTextStyle({
    final double fontSize = fontSize14,
    final double letterSpacing = defaultLetterSpacingPoint5,
    final double wordSpacing = defaultWordSpacingPoint3,
    final double height = defaultHeight1_2,
    final double? fontHeight,
    final String fontType = appFontInter,
    final Color fontColor = AppColors.blackColor,
    final FontWeight fontWeight = FontWeight.w500,
    final TextDecoration decoration = TextDecoration.none,
    final Color backgroundColor = Colors.transparent,
  }) {
    // assert(
    // wordHeight / (fontSize ?? 14) >= 1.2,
    // "Line height must be greater then 1.2. By Default 1.2 ",
    // );
    // assert(
    // height == null || height / (fontSize ?? 14) < 4,
    // "Line Height is greater then 4",
    // );

    final double heightMetrics =
        fontHeight == null ? height : fontHeight / fontSize;
    Paint? paint;
    paint = Paint();
    paint.color = backgroundColor;

    return TextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: heightMetrics,
      fontFamily: fontType,
      color: fontColor,
      fontWeight: fontWeight,
      decoration: decoration,
      background: paint,
    );
  }
}

const double fontSize42 = 42;
const double fontSize18 = 18;
const double fontSize14 = 14;
const double defaultHeight1_2 = 1.2;
const double defaultLetterSpacingPoint5 = .5;
const double defaultWordSpacingPoint3 = .3;
