import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/extension/string_literal.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/configuration.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:my_sutra/generated/assets.dart';

class TextFormWithCountryCode extends StatefulWidget {
  const TextFormWithCountryCode({
    super.key,
    required this.controller,
    required this.countryCode,
    this.isMandatory = true,
    this.fillColor,
    this.textStyle,
    this.isEnabled = true,
    this.focusNode,
    this.nextFocusNode,
    this.onDone,
    this.textInputAction = TextInputAction.done,
    this.hintTextStyle,
    this.title,
  });

  final TextEditingController controller;
  final TextEditingController countryCode;
  final TextStyle? textStyle;
  final bool isMandatory;
  final Color? fillColor;
  final bool isEnabled;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final Function(String text)? onDone;
  final TextStyle? hintTextStyle;
  final String? title;

  @override
  State<TextFormWithCountryCode> createState() =>
      _TextFormWithCountryCodeState();
}

class _TextFormWithCountryCodeState extends State<TextFormWithCountryCode> {
  final bool countryCodeEditable = true;

  @override
  void initState() {
    super.initState();
    widget.countryCode.text = "+91";
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      title: widget.title,
      prefixWidget: _getCountryPicker(),
      style:
          widget.textStyle ?? theme.publicSansFonts.regularStyle(fontSize: 16),
      validator: (value) => value.trim().validateMobile(),
      textInputType: TextInputType.number,
      fillColor: widget.fillColor,
      controller: widget.controller,
      borderColor: widget.fillColor == null
          ? Colors.white.withOpacity(0.06)
          : AppColors.blackColor.withOpacity(0.08),
      suffixWidget: null,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(
          AppConfiguration.mobileNumberMaxLength,
        ),
      ],
      onChange: (String onChange) {},
      onDone: (String text) {
        widget.onDone?.call(text);
      },
      focuse: (bool onFocus) {},
    );
  }

  Widget _getCountryPicker() {
    return Container(
      alignment: Alignment.center,
      width: 120,
      child: IgnorePointer(
        child: CountryPickerDropdown(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          initialValue: 'IN',
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
          dropdownColor: widget.fillColor ?? AppColors.blackColor,
          onValuePicked: (country) {
            widget.countryCode.text = country.phoneCode;
          },
          iconSize: 0,
          itemBuilder: (country) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CountryPickerUtils.getDefaultFlagImage(country),
                    ),
                  ),
                  component.text(
                    '+${country.phoneCode}',
                    overflow: TextOverflow.ellipsis,
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontSize: 16,
                    ),
                  ),
                  component.assetImage(path: Assets.iconsDropdown)
                ],
              ),
            );
          },
          isExpanded: true,
        ),
      ),
    );
  }
}
