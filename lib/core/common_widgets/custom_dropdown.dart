import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? title;
  final Function(DropDownValueModel)? onChanged;
  final SingleValueDropDownController controller;
  final String? hintText;
  final List<DropDownValueModel> dropDownList;
  final String? Function(String?)? validator;
  final double? borderRadius;

  const CustomDropdown({
    super.key,
    this.title,
    this.onChanged,
    required this.controller,
    this.hintText,
    required this.dropDownList,
    this.validator,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: DropDownTextField(
        clearOption: false,
        dropDownIconProperty: IconProperty(
            icon: Icons.keyboard_arrow_down, color: AppColors.color0xFF989898),
        onChanged: (val) => onChanged?.call(val),
        controller: controller,
        textFieldDecoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText ?? "Please select ",
          border: _getBorder(),
          errorBorder: _getBorder(borderColor: Colors.redAccent),
          focusedBorder: _getBorder(),
          enabledBorder: _getBorder(),
          filled: true,
          fillColor: AppColors.white,
        ),
        dropDownItemCount: 7,
        dropDownList: dropDownList,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  InputBorder _getBorder({Color? borderColor}) {
    return OutlineInputBorder(
        borderRadius: _getBorderRadius,
        borderSide: BorderSide(
            color: borderColor ?? AppColors.color0xFFDADCE0, width: 1));
  }

  BorderRadius get _getBorderRadius {
    return BorderRadius.circular(borderRadius ?? 12);
  }
}
