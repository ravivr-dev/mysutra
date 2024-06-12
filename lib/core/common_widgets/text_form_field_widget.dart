import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';


class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.initialData,
    this.title,
    this.controller,
    this.onChange,
    this.onDone,
    this.onSaved,
    this.style,
    this.prefixWidget,
    this.borderRadius = 30,
    this.hintText,
    this.hintTextStyle,
    this.suffixWidget,
    this.readOnly = false,
    this.isEnabled = true,
    this.onTap,
    this.maxLength = 256,
    this.maxLines = 1,
    this.horizontalContentPadding = 20,
    this.verticalContentPadding = 14,
    this.textInputType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization,
    this.fillColor,
    this.focuse,
    this.validator,
    this.isFocusedBorder = false,
    this.focusNode,
    this.nextFocusNode,
    this.prefix,
    this.isPassword = false,
    this.showBorder = true,
    this.borderColor,
    this.textInputAction = TextInputAction.done,
    this.obscureIconColor,
    this.autoFocus = false,
    this.filled = false,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.contentPadding,
  });
  final String? initialData;
  final String? title;
  final Function(String onChange)? onChange;
  final Function(String onSave)? onSaved;
  final Function(String text)? onDone;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final Widget? prefixWidget;
  final Widget? prefix;
  final Widget? suffixWidget;
  final double borderRadius;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? style;
  final TextInputType textInputType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool isEnabled;
  final bool readOnly;
  final void Function()? onTap;
  final int? maxLines;
  final int maxLength;
  final double horizontalContentPadding;
  final double verticalContentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final Color? obscureIconColor;
  final Function(bool onFocus)? focuse;
  final Function(String value)? validator;
  final bool isFocusedBorder;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool showBorder;
  final bool autoFocus;
  final bool filled;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? contentPadding;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  void initState() {
    if (widget.initialData != null && widget.initialData != '' ||
        widget.controller?.text.isNotEmpty == true) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          InkWell(
            onTap: () {},
            child: component.text(
              widget.title,
              style: theme.publicSansFonts.semiBoldStyle(
                fontSize: 14,
                height: 22,
              ),
            ),
          ),
          component.spacer(height: 4),
        ],
        TextFormField(
          key: widget.key,
          initialValue: widget.initialData,
          obscureText: widget.isPassword,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          enabled: widget.isEnabled,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          onSaved: (newValue) => widget.onSaved,
          onChanged: (value) {},
          textAlignVertical: TextAlignVertical.center,
          style: widget.style ??
              theme.publicSansFonts.regularStyle(
                fontSize: 18,
              ),
          cursorWidth: 1,
          textCapitalization: widget.textCapitalization != null
              ? widget.textCapitalization!
              : widget.textInputType == TextInputType.text
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines,
          autofocus: widget.autoFocus,
          onEditingComplete: () {},
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          validator: (text) =>
          widget.validator != null ? widget.validator!(text ?? "") : null,
          decoration: InputDecoration(
            prefixIconConstraints: widget.prefixIconConstraints,
            suffixIconConstraints: widget.suffixIconConstraints,
            counterText: '',
            isDense: true,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(
                  vertical: widget.verticalContentPadding,
                  horizontal: widget.horizontalContentPadding,
                ),
            prefixIcon: widget.prefixWidget,
            hintStyle: widget.hintTextStyle ??
                theme.publicSansFonts.regularStyle(
                  fontSize: 18,
                ),
            hintText: widget.hintText ?? "",
            errorStyle: theme.publicSansFonts.regularStyle(
              fontSize: 14,
            ),
            prefix: widget.prefix,
            fillColor: widget.fillColor ?? AppColors.colorFF6161,
            filled: widget.filled,
            border: _getBorder(),
            focusedBorder: _getFocusedBorder(),
            enabledBorder: _getEnabledBorder(),
            errorBorder: _getErrorBorder(),
            disabledBorder: _disabledBorder(),
            focusedErrorBorder: _getErrorBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: widget.suffixWidget,
          ),
        ),
      ],
    );
  }

  InputBorder _getBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  InputBorder _getEnabledBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.greyD9,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  InputBorder _getFocusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: widget.borderColor ?? AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  InputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: widget.fillColor != null
            ? Colors.transparent
            : AppColors.colorFF6161,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  InputBorder _disabledBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: AppColors.greyD9),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

// @override
// void dispose() {
//   super.dispose();
//   _focus.removeListener(_onFocusChange);
//   _focus.dispose();
// }
}
