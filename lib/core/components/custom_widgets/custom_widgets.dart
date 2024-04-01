// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:ui';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/components/config/theme/theme.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/injection_container.dart';

class CustomWidgets extends AilCustomWidgets {
  //Adding App Theme to Widgets

  final AppTheme theme = sl<AppTheme>();

  @override
  AiloitteFonts get fonts {
    return theme.fonts;
  }

  @override
  AiloitteColors get colors {
    return theme.colors;
  }

  //Customising Widgets according to App Specific Design

  ///Example
  // @override
  // PreferredSizeWidget appBar({
  //   final Key? key,
  //   final String? title,
  //   final TextStyle? titleStyle,
  //   final Function? callBack,
  //   final Widget? leading,
  //   final List<Widget>? actions,
  //   final Color? backgroundColor,
  //   final Gradient? gradient,
  //   final double? toolbarHeight,
  //   final bool? showBackButton,
  //   final bool? centerTitle,
  // }) {
  //   return AiloitteAppBarWidget(
  //     key: key,
  //     backgroundColor: Colors.red,
  //   );
  // }

  Widget blueContainedButton({
    final VoidCallback? onTap,
    final VoidCallback? preTap,
    final ValueNotifier<AiloitteButtonState>? buttonStateNotifier,
    final String? title,
    final TextStyle? titleStyle,
    final Widget? widget,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final double? height,
    final double? width,
    final double? borderRadius,
    final Color? enabledColor,
    final Color? disabledColor,
    final double? loaderSize,
    final Color? loaderColor,
    final List<BoxShadow>? boxShadow,
    final bool isPrefixedWidget = false,
    final TextAlign? titleTextAlign,
  }) {
    return AiloitteContainedButtonWidget(
      titleTextAlign: titleTextAlign,
      buttonStateNotifier: buttonStateNotifier,
      title: title,
      borderRadius: borderRadius,
      height: height ?? 52,
      onTap: onTap,
      preTap: preTap,
      padding: padding,
      width: width,
      enabledColor: enabledColor ?? AppColors.primaryColor,
      disabledColor: disabledColor,
      loaderColor: AppColors.white,
      loaderSize: loaderSize,
      titleStyle: theme.publicSansFonts.semiBoldStyle(
        fontSize: 18,
        height: 26,
        fontColor: AppColors.white,
      ),
      margin: margin,
      widget: widget,
      boxShadow: boxShadow,
      isPrefixedWidget: isPrefixedWidget,
    );
  }

  // @override
  // Widget containedButton({
  //   final VoidCallback? onTap,
  //   final ValueNotifier<AiloitteButtonState>? buttonStateNotifier,
  //   final String? title,
  //   final TextStyle? titleStyle,
  //   final Widget? widget,
  //   final EdgeInsets? padding,
  //   final EdgeInsets? margin,
  //   final double? height,
  //   final double? width,
  //   final double? borderRadius,
  //   final Color? enabledColor,
  //   final Color? disabledColor,
  //   final double? loaderSize,
  //   final Color? loaderColor,
  // }) {
  //   return AiloitteContainedButtonWidget(
  //     buttonStateNotifier: buttonStateNotifier,
  //     title: title,
  //     borderRadius: borderRadius,
  //     height: height ?? 48,
  //     onTap: onTap,
  //     padding:
  //         padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
  //     width: width,
  //     enabledColor: enabledColor ?? AppColors.primaryColor,
  //     disabledColor: disabledColor,
  //     loaderColor: loaderColor,
  //     loaderSize: loaderSize,
  //     titleStyle: titleStyle ??
  //         theme.publicSansFonts.semiBoldStyle(
  //           fontSize: 16,
  //           fontColor: AppColors.white,
  //         ),
  //     margin: margin,
  //     widget: widget,
  //   );
  // }

  Widget whiteContainedButton({
    final VoidCallback? onTap,
    final ValueNotifier<AiloitteButtonState>? buttonStateNotifier,
    final String? title,
    final TextStyle? titleStyle,
    final Widget? widget,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final double? height,
    final double? width,
    final double? borderRadius,
    final Color? enabledColor,
    final Color? disabledColor,
    final double? loaderSize,
    final Color? loaderColor,
    final Color? titleColor,
    final bool isPrefixedWidget = false,
    final TextAlign? titleTextAlign,
  }) {
    return AiloitteContainedButtonWidget(
      titleTextAlign: titleTextAlign,
      buttonStateNotifier: buttonStateNotifier,
      title: title,
      borderRadius: borderRadius,
      height: height ?? 52,
      onTap: onTap,
      padding: padding,
      width: width,
      enabledColor: AppColors.white,
      disabledColor: disabledColor,
      loaderColor: AppColors.white,
      loaderSize: loaderSize,
      titleStyle: titleStyle ??
          theme.publicSansFonts.semiBoldStyle(
            fontSize: 18,
            height: 26,
            fontColor: AppColors.primaryColor,
          ),
      margin: margin,
      widget: widget,
      isPrefixedWidget: isPrefixedWidget,
    );
  }

  Widget lightGreyContainedButton({
    final VoidCallback? onTap,
    final ValueNotifier<AiloitteButtonState>? buttonStateNotifier,
    final String? title,
    final TextStyle? titleStyle,
    final Widget? widget,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final double? height,
    final double? width,
    final double? borderRadius,
    final Color? enabledColor,
    final Color? disabledColor,
    final double? loaderSize,
    final Color? loaderColor,
    final Color? titleColor,
    final bool isPrefixedWidget = false,
    final TextAlign? titleTextAlign,
  }) {
    return AiloitteContainedButtonWidget(
      titleTextAlign: titleTextAlign,
      buttonStateNotifier: buttonStateNotifier,
      title: title,
      borderRadius: borderRadius,
      height: height ?? 52,
      onTap: onTap,
      padding: padding,
      width: width,
      enabledColor: AppColors.primaryColor,
      disabledColor: disabledColor,
      loaderColor: AppColors.primaryColor,
      loaderSize: loaderSize,
      titleStyle: theme.publicSansFonts.semiBoldStyle(
        fontSize: 16,
        height: 20.0,
        fontColor: AppColors.blackColor,
      ),
      margin: margin,
      widget: widget,
      isPrefixedWidget: isPrefixedWidget,
    );
  }

  @override
  Widget outlinedButton({
    final VoidCallback? onTap,
    final ValueNotifier<AiloitteButtonState>? buttonStateNotifier,
    final String? title,
    final TextStyle? titleStyle,
    final Widget? widget,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final double? height,
    final double? width,
    final double? borderRadius,
    final double? borderWidth,
    final double? loaderSize,
    final Color? loaderColor,
    final Color? disabledColor,
    final Color? outlineBorderColor,
    final TextAlign? titleTextAlign,
  }) {
    return AiloitteOutlinedButtonWidget(
      titleTextAlign: titleTextAlign,
      buttonStateNotifier: buttonStateNotifier,
      title: title,
      borderRadius: borderRadius,
      height: height,
      onTap: onTap,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: width,
      disabledColor: disabledColor,
      loaderColor: loaderColor,
      loaderSize: loaderSize,
      titleStyle: titleStyle ??
          theme.publicSansFonts.semiBoldStyle(
            fontSize: 18,
            fontColor: AppColors.primaryColor,
          ),
      margin: margin,
      widget: widget,
      borderWidth: borderWidth ?? 1,
      outlineBorderColor: outlineBorderColor ?? AppColors.primaryColor,
    );
  }

  Widget blueTextButton({
    required final String title,
    required final VoidCallback callback,
    final TextStyle? titleStyle,
    final bool showUnderline = false,
  }) {
    return AiloitteTextButtonWidget(
      title,
      callback: callback,
      titleStyle: titleStyle ??
          theme.publicSansFonts.semiBoldStyle(
            fontColor: AppColors.primaryColor,
            fontSize: 18,
            height: 26,
          ),
      showUnderline: showUnderline,
    );
  }

  Widget customDropdownTextField({
    final double? padding,
    required final List<String> items,
    final Function(String?)? onChange,
    final Function(String?)? validator,
    final String? defaultValue,
    final String? hint,
    final String? placeHolder,
    final double? height,
    final double? borderRadius,
    final double? borderWidth,
    final Color? borderColor,
    final Color? fillColor,
    final Color? dropdownColor,
    final TextStyle? textStyle,
    final TextStyle? hintStyle,
  }) {
    return AilDropdownTextWidget(
      items: items,
      padding: padding,
      defaultValue: defaultValue,
      height: height,
      hint: hint,
      hintStyle: hintStyle,
      onChange: onChange,
      validator: validator,
      placeHolder: placeHolder ?? '',
      borderColor: borderColor ?? AppColors.white.withOpacity(0.06),
      borderRadius: borderRadius ?? 18,
      borderWidth: 2,
      fillColor: fillColor ?? AppColors.primaryColor,
      textStyle: textStyle ??
          theme.publicSansFonts.mediumStyle(
            fontSize: 18,
            fontColor: AppColors.white,
          ),
      dropdownColor: dropdownColor ?? AppColors.blackColor,
    );
  }

  ///Use customDropdownOnObjectField for Objects
  Widget customDropdownOnStringField({
    final String? title,
    final EdgeInsets? padding,
    required final List<String> items,
    final Function(String?)? onChange,
    final Function(String?)? validator,
    final String? defaultValue,
    final String? hint,
    final String? placeHolder,
    final double? height,
    final double? borderRadius,
    final double? borderWidth,
    final Color? borderColor,
    final Color? fillColor,
    final Color? dropdownColor,
    final TextStyle? textStyle,
    final TextStyle? hintStyle,
    final Widget? icon,
  }) {
    return AilDropdownOnStringWidget(
      title: title,
      titleStyle: theme.publicSansFonts.mediumStyle(),
      items: items,
      padding: padding,
      defaultValue: defaultValue,
      height: height,
      hint: hint,
      hintStyle: hintStyle,
      onChange: onChange,
      validator: validator,
      placeHolder: placeHolder ?? '',
      borderColor: borderColor ?? AppColors.white.withOpacity(0.06),
      borderRadius: borderRadius ?? 18,
      borderWidth: 1,
      fillColor: fillColor ?? AppColors.primaryColor.withOpacity(0.1),
      textStyle: textStyle ??
          theme.publicSansFonts
              .regularStyle(fontSize: 16, fontColor: AppColors.primaryColor),
      dropdownColor: dropdownColor ?? AppColors.white,
      icon: icon,
    );
  }

  Widget customDropdownOnObjectField({
    final double? padding,
    required final List<DropDownObject> items,
    required final Function(DropDownObject?) onChange,
    required final Function(DropDownObject?) validator,
    final DropDownObject? defaultValue,
    final String? hint,
    final String? placeHolder,
    final double? height,
    final double? borderRadius,
    final double? borderWidth,
    final Color? borderColor,
    final Color? fillColor,
    final TextStyle? textStyle,
    final TextStyle? errorStyle,
    final Color? dropdownColor,
    final bool havingSubdivision = false,
  }) {
    return AilDropdownOnObjectsWidget(
      key: UniqueKey(),
      items: items,
      padding: padding,
      defaultValue: defaultValue,
      height: height,
      hint: hint,
      onChange: onChange,
      placeHolder: placeHolder ?? '',
      borderColor: borderColor ?? AppColors.white.withOpacity(0.06),
      borderRadius: borderRadius ?? 18,
      borderWidth: borderWidth ?? 2,
      fillColor: fillColor ?? AppColors.primaryColor.withOpacity(0.1),
      textStyle: textStyle ??
          theme.publicSansFonts.mediumStyle(
            fontSize: 18,
            fontColor: AppColors.white,
          ),
      errorStyle: errorStyle ??
          theme.publicSansFonts.regularStyle(
            fontSize: 13,
            fontColor: Colors.red,
          ),
      validator: (val) => validator(val),
      dropdownColor: dropdownColor ?? AppColors.blackColor,
    );
  }

  Widget blackScaffold({
    final Key? key,
    final bool useSafeArea = true,
    final Function? onWillPop,
    final PreferredSizeWidget? appBar,
    final Widget? child,
    final Widget? bottomSheet,
    final Widget? bottomNavigationBar,
    final Widget? floatingActionButton,
    final FloatingActionButtonLocation? floatingActionButtonLocation,
    final bool? resizeToAvoidBottomInset,
    final Color? backgroundColor,
    final EdgeInsets? bodyPadding,
    final Widget? drawer,
    final bool extendBody = false,
  }) {
    return AiloitteScaffoldWidget(
      useSafeArea: useSafeArea,
      onWillPop: onWillPop,
      appBar: appBar,
      drawer: drawer,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: AppColors.blackColor,
      bodyPadding: bodyPadding ?? const EdgeInsets.all(20),
      extendBody: extendBody,
      child: child,
    );
  }

  Widget scaffoldWithBlurBackground({
    final Key? key,
    final bool useSafeArea = false,
    final Function? onWillPop,
    final PreferredSizeWidget? appBar,
    final Widget? child,
    final Widget? bottomSheet,
    final Widget? bottomNavigationBar,
    final Widget? floatingActionButton,
    final FloatingActionButtonLocation? floatingActionButtonLocation,
    final bool? resizeToAvoidBottomInset,
    final Color? backgroundColor,
    final EdgeInsets? bodyPadding,
    final Widget? drawer,
    final bool extendBody = false,
  }) {
    return AiloitteScaffoldWidget(
      useSafeArea: false,
      onWillPop: onWillPop,
      appBar: appBar,
      drawer: drawer,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: AppColors.blackColor,
      bodyPadding: bodyPadding ?? EdgeInsets.zero,
      extendBody: extendBody,
      child: Container(
        // height: double.maxFinite,
        // width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: child,
        ),
      ),
    );
  }

  // Widget datePickerTexField(
  //   BuildContext context, {
  //   Color? borderColor,
  //   Color? fillColor,
  //   TextStyle? textStyle,
  //   double? height,
  //   String? hintText,
  //   TextStyle? hintTextStyle,
  //   final bool isEnable = true,
  //   final DateTime? initialDate,
  //   final DateTime? firstDate,
  //   final DateTime? lastDate,
  //   required TextEditingController controller,
  //   required Function(String onChange) onChange,
  //   required Function(String onDone) onDone,
  //   required Function(String validate) validator,
  //   required Function(DateTime dateTime) pickedDateTimeCallBack,
  //   Function(String dateTime)? pickedDateStrCallBack,
  //   String? dateFormat = "yyyy/MM/dd",
  // }) {
  //   return TextFormFieldWidget(
  //     controller: controller,
  //     readOnly: true,
  //     isEnabled: isEnable,
  //     onChange: onChange,
  //     textInputAction: TextInputAction.next,
  //     onTapCallback: () {
  //       getDatePicker(
  //         context: context,
  //         pickedDateTimeCallBack: (pickedDate) {
  //           pickedDateTimeCallBack(pickedDate);
  //           final DateFormat dateFormatObj =
  //               DateFormat(dateFormat ?? Constants.serverDateFormat_);
  //           pickedDateStrCallBack?.call(dateFormatObj.format(pickedDate));
  //         },
  //         initialDate: initialDate,
  //         lastDate: lastDate,
  //         firstDate: firstDate,
  //       );
  //     },
  //     onDone: onDone,
  //     validator: validator,
  //     focuse: (focus) {},
  //     borderRadius: 14,
  //     hintText: hintText,
  //     hintTextStyle: hintTextStyle,
  //     style: textStyle ??
  //         theme.publicSansFonts.mediumStyle(
  //           fontSize: 16,
  //           fontColor: AppColors.blackColor,
  //         ),
  //     // fillColor: AppColors.whiteColor,
  //     // borderColor: Colors.white.withOpacity(0.06),
  //     borderColor: borderColor ?? AppColors.blackColor.withOpacity(0.08),
  //     fillColor: fillColor ?? AppColors.white,
  //     inputFormatters: [
  //       DateTextFormatter(),
  //     ],
  //     textInputType: TextInputType.number,
  //     suffixWidget: GestureDetector(
  //       onTap: () {
  //         debugPrint(lastDate.toString());
  //         debugPrint(firstDate.toString());
  //         debugPrint(initialDate.toString());
  //         getDatePicker(
  //           context: context,
  //           pickedDateTimeCallBack: (pickedDate) =>
  //               pickedDateTimeCallBack(pickedDate),
  //           initialDate: initialDate,
  //           lastDate: lastDate,
  //           firstDate: firstDate,
  //         );
  //       },
  //       child: component.assetImage(
  //         path: "",
  //         color: AppColors.darkGrey.withOpacity(0.7),
  //       ),
  //     ),
  //   );
  // }

  // void getDatePicker({
  //   required final BuildContext context,
  //   required Function(DateTime dateTime) pickedDateTimeCallBack,
  //   final DateTime? initialDate,
  //   final DateTime? firstDate,
  //   final DateTime? lastDate,
  // }) {
  //   showDatePicker(
  //     builder: (context, child) => Theme(
  //       data: ThemeData().copyWith(
  //         colorScheme: ColorScheme.light(
  //           primary: AppColors.cardColor,
  //           onPrimary: AppColors.white.withOpacity(.9),
  //           background: AppColors.backgroundColor,
  //           secondary: AppColors.seaGreen2ED573,
  //           onSecondary: AppColors.seaGreen2ED573.withOpacity(1.0),
  //         ),
  //       ),
  //       child: child ?? Container(),
  //     ),
  //     initialDatePickerMode:
  //         initialDate == null ? DatePickerMode.year : DatePickerMode.day,
  //     context: context,
  //     initialDate: initialDate ?? DateTime.now(),
  //     firstDate: firstDate ?? DateTime(1950),
  //     lastDate: lastDate ?? DateTime.now(),
  //   ).then(
  //     (DateTime? pickedDate) {
  //       if (pickedDate != null) {
  //         pickedDateTimeCallBack(pickedDate);
  //         // final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  //         //
  //         // controller.text = dateFormat.format(pickedDate);
  //         //
  //         // log(controller.text);
  //       }
  //     },
  //   );
  // }

  // Widget timePickerTexFeild(
  //   BuildContext context, {
  //   Color? borderColor,
  //   Color? fillColor,
  //   TextStyle? textStyle,
  //   double? height,
  //   String? hintText,
  //   TextStyle? hintTextStyle,
  //   required TextEditingController controller,
  //   required Function(String onChange) onChange,
  //   required Function(String onDone) onDone,
  //   required Function(String validate) validator,
  //   required Function(TimeOfDay) onSelectTime,
  // }) {
  //   return SizedBox(
  //     height: height ?? 54,
  //     child: TextFormFieldWidget(
  //       controller: controller,
  //       onChange: onChange,
  //       onDone: onDone,
  //       readOnly: true,
  //       validator: validator,
  //       focuse: (focus) {},
  //       borderRadius: 14,
  //       onTapCallback: () {
  //         showTimePicker(
  //           initialTime: TimeOfDay.now(),
  //           builder: (context, child) => Theme(
  //             data: ThemeData().copyWith(
  //               colorScheme: const ColorScheme.light(
  //                 primary: AppColors.blackColor,
  //                 onPrimary: AppColors.type2,
  //               ),
  //             ),
  //             child: child ?? Container(),
  //           ),
  //           context: context,
  //         ).then(
  //           (TimeOfDay? pickedTime) {
  //             if (pickedTime != null) {
  //               controller.text = pickedTime.format(context);
  //               onSelectTime(pickedTime);
  //             }
  //           },
  //         );
  //       },
  //       hintText: hintText,
  //       hintTextStyle: hintTextStyle,
  //       style: textStyle ??
  //           theme.publicSansFonts.mediumStyle(
  //             fontSize: 16,
  //             fontColor: AppColors.blackColor,
  //           ),
  //       borderColor: borderColor ?? AppColors.blackColor.withOpacity(0.08),
  //       fillColor: fillColor ?? AppColors.white,
  //       inputFormatters: [
  //         DateTextFormatter(),
  //       ],
  //       textInputType: TextInputType.number,
  //       suffixWidget: GestureDetector(
  //         onTap: () {
  //           showTimePicker(
  //             initialTime: TimeOfDay.now(),
  //             builder: (context, child) => Theme(
  //               data: ThemeData().copyWith(
  //                 colorScheme: const ColorScheme.light(
  //                   primary: AppColors.blackColor,
  //                   onPrimary: AppColors.type2,
  //                 ),
  //               ),
  //               child: child ?? Container(),
  //             ),
  //             context: context,
  //           ).then(
  //             (TimeOfDay? pickedTime) {
  //               if (pickedTime != null) {
  //                 controller.text = pickedTime.format(context);

  //                 log(controller.text);
  //               } else {
  //                 //TODO: show error toast
  //               }
  //             },
  //           );
  //         },
  //         child: component.assetImage(
  //           path: "",
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget descriptiveTextfield({
  //   required TextEditingController controller,
  //   Function(String onChange)? onChange,
  //   Function(String onDone)? onDone,
  //   Function(String validate)? validator,
  //   TextInputAction? textInputAction,
  //   Color? borderColor,
  //   Color? fillColor,
  //   TextStyle? textStyle,
  //   double? height,
  //   String? hintText,
  //   TextStyle? hintTextStyle,
  //   double? borderRadius,
  //   bool showBorder = true,
  //   bool isFocusedBorder = false,
  //   int? maxLines,
  //   FocusNode? focusNode,
  //   EdgeInsets contentPadding =
  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  //   TextInputType textInputType = TextInputType.text,
  //   final String? initialText,
  // }) {
  //   return TextFormFieldWidget(
  //     initialText: initialText,
  //     maxLines: maxLines,
  //     enabledBorderColor: AppColors.primaryLight,
  //     controller: controller,
  //     focusNode: focusNode,
  //     isFocusedBorder: isFocusedBorder,
  //     horizontalContentPadding: contentPadding.left,
  //     verticalContentPadding: contentPadding.top,
  //     onChange: onChange ?? (val) {},
  //     onDone: onDone ?? (val) {},
  //     textInputAction: textInputAction ?? TextInputAction.done,
  //     validator: validator ?? (val) {},
  //     focuse: (focus) {},
  //     hintTextStyle: hintTextStyle ??
  //         theme.publicSansFonts.mediumStyle(
  //           fontSize: 16,
  //           fontColor: AppColors.black33.withOpacity(0.4),
  //         ),
  //     borderRadius: borderRadius ?? 14,
  //     hintText: hintText,
  //     textInputType: textInputType,
  //     style: textStyle ??
  //         theme.publicSansFonts.mediumStyle(
  //           fontSize: 16,
  //           fontColor: AppColors.blackColor,
  //         ),
  //     showBorder: showBorder,
  //     borderColor: borderColor ?? AppColors.blackColor.withOpacity(0.08),
  //     fillColor: fillColor ?? AppColors.white,
  //   );
  // }

  @override
  Widget scaffold({
    final Key? key,
    final bool useSafeArea = false,
    final Function? onWillPop,
    final PreferredSizeWidget? appBar,
    final Widget? child,
    final Widget? bottomSheet,
    final Widget? bottomNavigationBar,
    final Widget? floatingActionButton,
    final FloatingActionButtonLocation? floatingActionButtonLocation,
    final bool? resizeToAvoidBottomInset,
    final Color? backgroundColor,
    final EdgeInsets? bodyPadding,
    final Widget? drawer,
    final bool extendBody = false,
    final bool extendBodyBehindAppBar = false,
  }) {
    return AiloitteScaffoldWidget(
      useSafeArea: useSafeArea,
      onWillPop: onWillPop,
      appBar: appBar,
      drawer: drawer,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? AppColors.white,
      extendBody: extendBody,
      bodyPadding: bodyPadding ?? EdgeInsets.zero,
      child: child,
    );
  }

  // @override
  // Widget textField({
  //   final Key? key,
  //   final String? labelText,
  //   final Widget? suffix,
  //   final TextStyle? labelStyle,
  //   required final TextEditingController controller,
  //   dynamic Function(String)? onChange,
  //   final TextStyle? style,
  //   final Widget? prefixWidget,
  //   final double? borderRadius,
  //   final String? hintText,
  //   final TextStyle? hintTextStyle,
  //   final Widget? suffixWidget,
  //   final bool? isEnabled,
  //   final Function? onTapCallback,
  //   final int? maxLines,
  //   final EdgeInsets? contentPadding,
  //   final TextInputType? textInputType,
  //   final List<TextInputFormatter>? inputFormatters,
  //   final TextCapitalization? textCapitalization,
  //   final Color? fillColor,
  //   final Function(bool)? focus,
  //   final String? Function(String?)? validator,
  //   final bool? showFocusedBorder,
  //   final FocusNode? focusNode,
  //   final Widget? prefix,
  //   final TextInputAction? textInputAction,
  //   final bool? obscureText,
  //   final String? headerText,
  //   final bool? isRequired,
  //   final InputDecoration? inputDecoration,
  //   final double? cursorWidth,
  //   final bool? filled,
  //   final bool? isDense,
  //   final TextStyle? errorStyle,
  //   final Color? borderColor,
  //   final Color? errorBorderColor,
  //   final Color? focusedBorderColor,
  //   final EdgeInsets? headerPadding,
  //   final TextStyle? headerStyle,
  //   final bool isDisposable = false,
  //   final bool showBorder = true,
  //   final int? maxLength,
  // }) {
  //   return AiloitteTextFieldWidget(
  //     maxLength: maxLength,
  //     showBorder: showBorder,
  //     labelText: labelText,
  //     suffix: suffix,
  //     labelStyle: labelStyle,
  //     controller: controller,
  //     onChange: onChange,
  //     style: style ??
  //         theme.publicSansFonts.mediumStyle(
  //           fontSize: 16,
  //         ),
  //     prefixWidget: prefixWidget,
  //     borderRadius: borderRadius ?? 12,
  //     hintText: hintText,
  //     hintTextStyle: hintTextStyle ??
  //         theme.publicSansFonts.mediumStyle(
  //           fontSize: 16,
  //           fontColor: AppColors.black21.withOpacity(0.4),
  //         ),
  //     suffixWidget: suffixWidget,
  //     isEnabled: isEnabled ?? true,
  //     onTapCallback: onTapCallback,
  //     maxLines: maxLines ?? 1,
  //     contentPadding: contentPadding ??
  //         const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     textInputType: textInputType ?? TextInputType.text,
  //     inputFormatters: inputFormatters,
  //     textCapitalization: textCapitalization ?? TextCapitalization.sentences,
  //     fillColor: fillColor ?? Colors.transparent,
  //     focus: focus,
  //     validator: validator,
  //     showFocusedBorder: showFocusedBorder ?? false,
  //     focusNode: focusNode,
  //     prefix: prefix,
  //     textInputAction: textInputAction ?? TextInputAction.done,
  //     obscureText: obscureText ?? false,
  //     headerText: headerText,
  //     isRequired: isRequired ?? false,
  //     inputDecoration: inputDecoration,
  //     cursorWidth: cursorWidth ?? 1,
  //     filled: filled ?? true,
  //     isDense: isDense ?? true,
  //     errorStyle: errorStyle,
  //     borderColor: borderColor ?? AppColors.black21,
  //     errorBorderColor: errorBorderColor,
  //     focusedBorderColor: focusedBorderColor ?? AppColors.primaryColor,
  //     isDisposable: isDisposable,
  //     headerPadding: headerPadding ??
  //         const EdgeInsets.only(
  //           bottom: 10,
  //         ),
  //     headerStyle: headerStyle,
  //   );
  // }

// ignore: type_annotate_public_apis, always_declare_return_types
// getDatePicker(
//   BuildContext context, {
//   required TextEditingController controller,
//   required Function(DateTime date) callBack,
// }) async {

// }
}
