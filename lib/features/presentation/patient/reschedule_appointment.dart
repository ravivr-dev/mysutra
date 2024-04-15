import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_dropdown.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/patient/widgets/week_picker.dart';

class ReScheduleAppointment extends StatefulWidget {
  const ReScheduleAppointment({super.key});

  @override
  State<ReScheduleAppointment> createState() => _RescheduleAppointmentState();
}

class _RescheduleAppointmentState extends State<ReScheduleAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,
            color: AppColors.color0xFF00082F.withOpacity(.27)),
        title: component.text(
            context.stringForKey(StringKeys.rescheduleAppointment),
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 20,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WeekPicker(),
            component.spacer(height: 24),
            _buildText(value: context.stringForKey(StringKeys.availableTime)),
            component.spacer(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: [
                _buildTimeWidget(),
                _buildTimeWidget(),
                _buildTimeWidget(),
                _buildTimeWidget(),
                _buildTimeWidget(),
                _buildTimeWidget(),
                _buildTimeWidget(),
                _buildTimeWidget(),
              ],
            ),
            component.spacer(height: 24),
            _buildText(
                value: context.stringForKey(StringKeys.patientDetails),
                fontSize: 16),
            component.spacer(height: 16),
            _buildText(value: context.stringForKey(StringKeys.fullName)),
            component.spacer(height: 10),
            _buildTextField(),
            component.spacer(height: 20),
            _buildText(value: context.stringForKey(StringKeys.age)),
            component.spacer(height: 10),
            _buildTextField(),
            component.spacer(height: 20),
            _buildText(value: context.stringForKey(StringKeys.gender)),
            component.spacer(height: 10),
            CustomDropdown(
              controller: SingleValueDropDownController(),
              dropDownList: [],
              height: 70,
              borderRadius: 90,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 33),
            ),
            component.spacer(height: 20),
            _buildText(
                value: context.stringForKey(StringKeys.writeYourProblem)),
            component.spacer(height: 10),
            _buildTextField(maxLines: 5),
            component.spacer(height: 30),
            CustomButton(
              text: context.stringForKey(StringKeys.proceedToPay),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({int? maxLines}) {
    return SizedBox(
      height: maxLines == null ? 70 : null,
      child: component.textField(
        controller: TextEditingController(),
        fillColor: AppColors.white,
        hintText: '',
        contentPadding: const EdgeInsets.only(top: 25, bottom: 25, left: 33),
        borderRadius: maxLines != null ? 30 : 90,
        maxLines: maxLines,
        filled: true,
        focusedBorderColor: AppColors.color0xFFDADCE0,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }

  Widget _buildTimeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
          border: Border.all(color: AppColors.greyEC)),
      child: component.text('09:00 AM',
          style: theme.publicSansFonts.regularStyle(
            fontSize: 12,
            fontColor: AppColors.black81,
          )),
    );
  }

  Widget _buildText({required String value, double? fontSize}) {
    return component.text(value,
        style: theme.publicSansFonts.mediumStyle(fontSize: fontSize));
  }
}
