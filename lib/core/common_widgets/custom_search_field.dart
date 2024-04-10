import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:searchfield/searchfield.dart';

class TextSearchField extends StatefulWidget {
  const TextSearchField({
    super.key,
    this.initialData,
    this.title,
    this.controller,
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
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.contentPadding,
    required this.suggestions,
    this.emptyWidget,
    this.onSuggestionTap,
  });
  final List<SearchFieldListItem<dynamic>> suggestions;
  final SearchFieldListItem<String>? initialData;
  final Widget? emptyWidget;
  final String? title;
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
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? contentPadding;
  final Function(SearchFieldListItem<dynamic>)? onSuggestionTap;

  @override
  State<TextSearchField> createState() => _TextSearchFieldState();
}

class _TextSearchFieldState extends State<TextSearchField> {
  @override
  void initState() {
    if (widget.initialData != null && widget.initialData != '' ||
        widget.controller?.text.isNotEmpty == true) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            component.text(
              widget.title,
              style: theme.publicSansFonts.semiBoldStyle(
                fontSize: 14,
                height: 22,
              ),
            ),
            component.spacer(height: 4),
          ],
          SearchField(
            onSuggestionTap: widget.onSuggestionTap,
            key: widget.key,
            suggestions: widget.suggestions,
            initialValue: widget.initialData,
            focusNode: widget.focusNode,
            emptyWidget: widget.emptyWidget ?? const SizedBox(),
            readOnly: widget.readOnly,
            itemHeight: 100,
            enabled: widget.isEnabled,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization != null
                ? widget.textCapitalization!
                : widget.textInputType == TextInputType.text
                    ? TextCapitalization.sentences
                    : TextCapitalization.none,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autoFocus,
            onTap: widget.onTap,
            validator: (text) =>
                widget.validator != null ? widget.validator!(text ?? "") : null,
            searchInputDecoration: InputDecoration(
              prefixIconConstraints: widget.prefixIconConstraints,
              suffixIconConstraints: widget.suffixIconConstraints,
              counterText: '',
              isDense: true,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
              prefixIcon: widget.prefixWidget,
              hintStyle: widget.hintTextStyle ??
                  theme.publicSansFonts
                      .regularStyle(fontSize: 18, fontColor: AppColors.blackAE),
              hintText: widget.hintText ??
                  "Please enter ${widget.title?.toLowerCase()}",
              errorStyle: theme.publicSansFonts.regularStyle(
                fontSize: 14,
              ),
              prefix: widget.prefix,
              fillColor: AppColors.error,
              border: _getBorder(),
              focusedBorder: _getFocusedBorder(),
              enabledBorder: _getEnabledBorder(),
              errorBorder: _getErrorBorder(),
              disabledBorder: _disabledBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: widget.suffixWidget,
            ),
          ),
        ],
      ),
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
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  InputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: widget.fillColor != null ? Colors.transparent : AppColors.error,
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
}
