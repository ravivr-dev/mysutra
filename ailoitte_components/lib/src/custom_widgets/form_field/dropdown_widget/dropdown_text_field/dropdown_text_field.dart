// // import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';
//
// export 'dropdown_text_field.dart';
//
// /// in dev,
// @Deprecated("IN DEV")
// class AilDropdownTextWidget extends StatefulWidget {
//   final double? padding;
//   final List<String>? items;
//   final Function(String?)? onChange;
//   final Function(String?)? validator;
//   final String? defaultValue;
//   final String? hint;
//   final String? placeHolder;
//   final double? height;
//   final double? borderRadius;
//   final double? borderWidth;
//   final Color? borderColor;
//   final Color? dropdownColor;
//   final Color? fillColor;
//   final TextStyle? textStyle;
//   final TextStyle? hintStyle;
//   final bool? showBorder;
//
//   const AilDropdownTextWidget({
//     Key? key,
//     this.onChange,
//     this.validator,
//     this.placeHolder = '',
//     this.defaultValue,
//     required this.items,
//     this.padding = 10,
//     this.height = 40,
//     this.hint = "Select",
//     this.borderColor,
//     this.borderRadius,
//     this.showBorder = true,
//     this.borderWidth,
//     this.textStyle,
//     this.fillColor,
//     this.dropdownColor,
//     this.hintStyle,
//   }) : super(key: key);
//
//   @override
//   State<AilDropdownTextWidget> createState() => _AilDropdownTextWidgetState();
// }
//
// class _AilDropdownTextWidgetState extends State<AilDropdownTextWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       padding: const EdgeInsets.only(left: 20),
//       decoration: BoxDecoration(
//         color: widget.fillColor,
//         // border: Border.all(
//         //   color: widget.borderColor ?? defaultBorderColor,
//         //   width: widget.borderWidth ?? defaultBorderWidth,
//         // ),
//         border: Border.all(color: const Color(0xFFDADCE0)),
//         borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
//       ),
//       constraints: const BoxConstraints(
//         minHeight: 40,
//         minWidth: 40,
//       ),
//       child: DropDownTextField(
//         clearOption: false,
//         // value: widget.defaultValue,
//         // decoration: InputDecoration(
//         //   contentPadding: EdgeInsets.symmetric(
//         //     horizontal: widget.padding ?? 12,
//         //     vertical: 14,
//         //   ),
//         //   focusedBorder: widget.showBorder == false
//         //       ? InputBorder.none
//         //       : OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
//         //           borderSide: BorderSide(
//         //             width: widget.borderWidth ?? 2,
//         //             color: widget.borderColor ?? defaultBorderColor,
//         //           ),
//         //         ),
//         //   enabledBorder: widget.showBorder == false
//         //       ? InputBorder.none
//         //       : OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
//         //           borderSide: BorderSide(
//         //             width: widget.borderWidth ?? 2,
//         //             color: widget.borderColor ?? defaultBorderColor,
//         //           ),
//         //         ),
//         // ),
//         // alignment: Alignment.centerLeft,
//         // icon: const Icon(Icons.keyboard_arrow_down_sharp),
//         // // elevation: 8,
//         // isExpanded: true,
//         // style: AiloitteTheme().fonts.mediumStyle(
//         //       fontSize: 16,
//         //       fontColor: AiloitteTheme().colors.text,
//         //     ),
//         onChanged: (newValue) {
//           setState(() {
//             if (widget.onChange != null && newValue is String?) {
//               widget.onChange!(newValue);
//             }
//           });
//         },
//         textFieldDecoration: InputDecoration(
//           border: InputBorder.none,
//         ),
//         validator: (val) => widget.validator?.call(val),
//         dropdownColor: widget.dropdownColor,
//         // hint: Text(
//         //   widget.hint ?? '',
//         //   style: widget.hintStyle,
//         //   textAlign: TextAlign.left,
//         // ),
//         dropDownIconProperty: IconProperty(
//             icon: Icons.keyboard_arrow_down, color: const Color(0xFF989898)),
//         dropDownList: widget.items?.map<DropDownValueModel>((String value) {
//               return DropDownValueModel(
//                 value: value,
//                 name: value,
//                 // child: Text(
//                 //   "$value${widget.placeHolder}",
//                 //   textAlign: TextAlign.start,
//                 //   style: widget.textStyle,
//                 // ),
//               );
//             }).toList() ??
//             [],
//       ),
//     );
//   }
// }
