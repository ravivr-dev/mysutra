import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';

import '../../ailoitte_component_injector.dart';
import '../utils/app_colors.dart';

class CustomOtpField extends StatelessWidget {
  final TextEditingController otpController;

  const CustomOtpField({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      margin: const EdgeInsets.symmetric(horizontal: 52.5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        showCursor: false,
        controller: otpController,
        style: theme.publicSansFonts.semiBoldStyle(
            fontSize: 22, letterSpacing: (context.screenWidth * .129)),
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        validator: (val) {
          if (val != null && val.length <= 6) {
            showErrorToast(
                context: context, message: 'Please enter a valid OTP!');
          }
          return null;
        },
      ),
    );
  }
}
