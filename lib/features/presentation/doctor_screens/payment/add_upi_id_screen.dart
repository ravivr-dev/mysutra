import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';

class AddUpiIdScreen extends StatefulWidget {
  final bool showBasicDetails;
  const AddUpiIdScreen({super.key, required this.showBasicDetails});

  @override
  State<AddUpiIdScreen> createState() => _AddUpiIdScreenState();
}

class _AddUpiIdScreenState extends State<AddUpiIdScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _mobCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _upiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: component.text(context.stringForKey(StringKeys.addUpiId)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              if (widget.showBasicDetails) ...[
                _title('Basic details'),
                TextFormFieldWidget(
                  title: 'Full name',
                  controller: _nameCtrl,
                ),
                const SizedBox(height: 5),
                TextFormWithCountryCode(
                  title: context.stringForKey(StringKeys.mobileNumber),
                  countryCode: _countryCode,
                  controller: _mobCtrl,
                  fillColor: AppColors.greyD9,
                ),
                const SizedBox(height: 5),
                TextFormFieldWidget(
                  title: "Email",
                  validator: (value) => value.isEmpty
                      ? 'Please Enter Email'
                      : !value.isValidEmail
                          ? 'Please Enter Valid Email'
                          : null,
                  hintText: 'Enter Email Address',
                  hintTextStyle: theme.publicSansFonts
                      .regularStyle(fontSize: 16, fontColor: AppColors.grey92),
                  controller: _emailCtrl,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(height: 20),
              ],
              _title('UPI Details'),
              TextFormFieldWidget(
                title: 'Add your UPI Handle',
                controller: _upiCtrl,
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                text: 'Add Bank Account',
              )
            ],
          ),
        ),
      ),
    );
  }

  _title(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.publicSansFonts
              .regularStyle(fontSize: 16, fontColor: AppColors.color0xFF1E293B),
        ),
        const Divider(color: AppColors.color0xFFDDDDDD),
        const SizedBox(height: 5)
      ],
    );
  }
}
