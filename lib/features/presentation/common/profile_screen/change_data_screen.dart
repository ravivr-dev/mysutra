import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_small_outline_buttom.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/config/navigation.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ChangeDataScreen extends StatefulWidget {
  const ChangeDataScreen({super.key, required this.args});

  final ChangeDataParams args;

  @override
  State<ChangeDataScreen> createState() => _ChangeDataScreenState();
}

class _ChangeDataScreenState extends State<ChangeDataScreen> {
  final TextEditingController _ccCtrl = TextEditingController();
  final TextEditingController _valCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  bool showOTP = false;

  @override
  void dispose() {
    _ccCtrl.dispose();
    _valCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ChangeEmailLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          showOTP = true;
        }
        if (state is ChangePhoneNumberLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          showOTP = true;
        }
        if (state is VerifyChangeLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          // showOTP = false;
          // AiloitteNavigation.intent(context, AppRoutes.homeRoute);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: widget.args.isEmail
                ? component
                    .text(context.stringForKey(StringKeys.changeEmailAddress))
                : component
                    .text(context.stringForKey(StringKeys.changeMobileNumber)),
            centerTitle: true,
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: showOTP
                ? CustomButton(
                    text: 'Confirm',
                    onPressed: () {
                      if (widget.args.isEmail) {
                        context.read<ProfileCubit>().verifyChangeEmail(
                            otp: int.tryParse(_otpCtrl.text)!);
                      } else {
                        context.read<ProfileCubit>().verifyChangePhoneNumber(
                            otp: int.tryParse(_otpCtrl.text)!);
                      }
                    },
                  )
                : CustomSmallOutlineButton(
                    text: 'Send OTP',
                    onPressed: () {
                      if (widget.args.isEmail) {
                        context
                            .read<ProfileCubit>()
                            .changeEmail(newEmail: _valCtrl.text);
                      } else {
                        context.read<ProfileCubit>().changePhoneNumber(
                            cc: _ccCtrl.text,
                            phoneNumber: int.tryParse(_valCtrl.text)!);
                      }
                    },
                  ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                if (widget.args.isEmail)
                  TextFormFieldWidget(
                    title: 'Enter new email address',
                    fillColor: AppColors.white,
                    filled: true,
                    borderRadius: 90,
                    horizontalContentPadding: 34,
                    verticalContentPadding: 22,
                    controller: _valCtrl,
                    style: theme.publicSansFonts.regularStyle(
                      fontSize: 16,
                    ),
                  )
                else
                  TextFormWithCountryCode(
                    title: "Enter new mobile number",
                    fillColor: AppColors.white,
                    filled: true,
                    countryCode: _ccCtrl,
                    controller: _valCtrl,
                    verticalContentPadding: 23,
                    // horizontalContentPadding: =,
                    borderRadius: 90,
                    textStyle: theme.publicSansFonts.regularStyle(fontSize: 16),
                  ),
                component.spacer(
                  height: 12,
                ),
                if (showOTP)
                  TextFormFieldWidget(
                    title: "Enter OTP Sent to  ${_valCtrl.text}",
                    fillColor: AppColors.white,
                    borderRadius: 90,
                    horizontalContentPadding: 34,
                    verticalContentPadding: 22,
                    textInputType: TextInputType.number,
                    filled: true,
                    controller: _otpCtrl,
                    autoFocus: true,
                    style: theme.publicSansFonts.regularStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChangeDataParams {
  ChangeDataParams(this.isEmail);

  final bool isEmail;
}
