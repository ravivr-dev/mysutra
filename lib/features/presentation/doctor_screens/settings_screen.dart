import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_dropdown.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import '../../../ailoitte_component_injector.dart';
import '../../../core/utils/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _dropDownController = SingleValueDropDownController();
  final List<String> _daysList = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  void dispose() {
    _dropDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.color0xFF00082F.withOpacity(.27),
        ),
        title: component.text(context.stringForKey(StringKeys.settings)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(
                text: context.stringForKey(StringKeys.sessionDuration)),
            component.spacer(height: 8),
            _buildDropDown(hintText: '30 min', borderRadius: 12),
            component.spacer(height: 20),
            _buildHeader(text: context.stringForKey(StringKeys.selectDays)),
            component.spacer(height: 8),
            _buildDaysWidget(),
            component.spacer(height: 20),
            const Divider(color: AppColors.color0xFFDADCE0),
            component.spacer(height: 20),
            _buildHeader(text: context.stringForKey(StringKeys.session1Timing)),
            component.spacer(height: 8),
            Row(
              children: [
                Expanded(child: _buildDropDown()),
                component.spacer(width: 8),
                Expanded(child: _buildDropDown()),
              ],
            ),
            component.spacer(height: 20),
            _buildHeader(text: context.stringForKey(StringKeys.session2Timing)),
            component.spacer(height: 8),
            Row(
              children: [
                Expanded(child: _buildDropDown()),
                component.spacer(width: 8),
                Expanded(child: _buildDropDown()),
              ],
            ),
            component.spacer(height: 48),
            _buildHeader(text: context.stringForKey(StringKeys.sessionFees)),
            component.spacer(height: 8),
            Row(
              children: [
                Expanded(child: _buildTextField()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: component.text(context.stringForKey(StringKeys.to),
                      style: theme.publicSansFonts.mediumStyle(
                          fontColor: AppColors.color0xFF40444C, fontSize: 16)),
                ),
                Expanded(child: _buildTextField()),
              ],
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {},
              text: context.stringForKey(StringKeys.saveChanges),
              buttonColor: AppColors.color0xFF8338EC,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDaysWidget() {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => _buildDay(text: _daysList[i], isOff: i == 6),
        separatorBuilder: (_, __) => component.spacer(width: 20),
        itemCount: _daysList.length,
      ),
    );
  }

  Widget _buildDay({
    required String text,
    required bool isOff,
  }) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isOff ? AppColors.color0xFFE8E9E9 : AppColors.color0xFF8338EC,
        shape: BoxShape.circle,
      ),
      child: component.text(text,
          style: theme.publicSansFonts.regularStyle(
            fontColor:
                isOff ? AppColors.color0xFF989898 : AppColors.color0xFFFEFEFE,
          )),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      height: 48,
      child: component.textField(
        controller: TextEditingController(),
        fillColor: AppColors.white,
        borderRadius: 90,
        filled: true,
        focusedBorderColor: AppColors.color0xFFDADCE0,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }

  Widget _buildDropDown({String? hintText, double borderRadius = 90}) {
    return CustomDropdown(
        controller: _dropDownController,
        hintText: hintText,
        borderRadius: borderRadius,
        dropDownList: const [
          DropDownValueModel(name: '30 min', value: '30 min')
        ]);
  }

  Widget _buildHeader({
    required String text,
  }) {
    return component.text(
      text,
      style: theme.publicSansFonts.semiBoldStyle(
        fontSize: 14,
        fontColor: AppColors.black21,
      ),
    );
  }
}
